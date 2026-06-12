import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ConnectionStatus { disconnected, connecting, connected, reconnecting }

class WebSocketClient {
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;

  Function(String)? onMessageReceived;
  Function(ConnectionStatus)? onConnectionStatusChanged;
  Function(String)? onError;

  String? _socketUrl;
  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _heartbeatInterval = Duration(minutes: 1);
  static const Duration _reconnectDelay = Duration(seconds: 5);

  ConnectionStatus get connectionStatus => _connectionStatus;
  bool get isConnected => _connectionStatus == ConnectionStatus.connected;

  // Initialize Socket with enhanced connection management
  void connect(String socketUrl) {
    _socketUrl = socketUrl;
    _setConnectionStatus(ConnectionStatus.connecting);

    try {
      _channel = WebSocketChannel.connect(Uri.parse(socketUrl));

      _channel?.stream.listen(
        (message) {
          debugPrint("Received WebSocket Message: $message");

          // Handle heartbeat response
          final decoded = _tryDecodeMessage(message);
          if (decoded != null && decoded['type'] == 'pong') {
            debugPrint("Heartbeat pong received");
            return;
          }

          onMessageReceived?.call(message);
        },
        onError: (error) {
          debugPrint("WebSocket error: $error");
          onError?.call(error.toString());
          _handleConnectionError();
        },
        onDone: () {
          log("WebSocket connection closed");
          _handleConnectionClosed();
        },
      );

      _setConnectionStatus(ConnectionStatus.connected);
      _reconnectAttempts = 0;
      _startHeartbeat();
      debugPrint("WebSocket connected to $socketUrl");
    } catch (e) {
      debugPrint("Failed to connect to WebSocket: $e");
      onError?.call(e.toString());
      _handleConnectionError();
    }
  }

  // Start heartbeat to keep connection alive
  void _startHeartbeat() {
    _stopHeartbeat();

    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (isConnected) {
        _sendHeartbeat();
      } else {
        _stopHeartbeat();
      }
    });
  }

  // Stop heartbeat timer
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  // Send heartbeat message
  void _sendHeartbeat() {
    try {
      final heartbeatMessage = jsonEncode({
        "type": "ping",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });

      _channel?.sink.add(heartbeatMessage);
      debugPrint("Heartbeat sent");
    } catch (e) {
      debugPrint("Failed to send heartbeat: $e");
      _handleConnectionError();
    }
  }

  // Handle connection errors
  void _handleConnectionError() {
    _setConnectionStatus(ConnectionStatus.disconnected);
    _stopHeartbeat();

    if (_reconnectAttempts < _maxReconnectAttempts) {
      _attemptReconnect();
    } else {
      debugPrint("Max reconnection attempts reached");
      onError?.call("Connection failed after $_maxReconnectAttempts attempts");
    }
  }

  // Handle connection closed
  void _handleConnectionClosed() {
    _setConnectionStatus(ConnectionStatus.disconnected);
    _stopHeartbeat();

    // Attempt reconnection if not manually disconnected
    if (_socketUrl != null) {
      _attemptReconnect();
    }
  }

  // Attempt to reconnect
  void _attemptReconnect() {
    if (_socketUrl == null) return;

    _reconnectAttempts++;
    _setConnectionStatus(ConnectionStatus.reconnecting);

    debugPrint(
      "Attempting to reconnect... (Attempt $_reconnectAttempts/$_maxReconnectAttempts)",
    );

    _reconnectTimer = Timer(_reconnectDelay, () {
      connect(_socketUrl!);
    });
  }

  // Set connection status and notify listeners
  void _setConnectionStatus(ConnectionStatus status) {
    if (_connectionStatus != status) {
      _connectionStatus = status;
      onConnectionStatusChanged?.call(status);
    }
  }

  // Try to decode JSON message safely
  Map<String, dynamic>? _tryDecodeMessage(String message) {
    try {
      return jsonDecode(message) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Join room with connection check
  void joinRoom(String? user1Id, String user2Id) {
    if (!isConnected) {
      debugPrint("Cannot join room: WebSocket not connected");
      return;
    }

    final message = jsonEncode({
      "type": "joinRoom",
      "user1Id": user1Id,
      "user2Id": user2Id,
    });

    try {
      _channel?.sink.add(message);
      if (kDebugMode) {
        log(
          "-------------- Joined room with user1Id: $user1Id and user2Id: $user2Id",
        );
      }
    } catch (e) {
      debugPrint("Failed to join room: $e");
      onError?.call("Failed to join room");
    }
  }

  // View messages with connection check
  void viewMessage(String chatroomId, String userId) {
    if (!isConnected) {
      debugPrint("Cannot view messages: WebSocket not connected");
      return;
    }

    final message = jsonEncode({
      "type": "viewMessages",
      "chatroomId": chatroomId,
      "userId": userId,
    });

    try {
      _channel?.sink.add(message);
      if (kDebugMode) {
        log(
          "View message sent for chatroomId: $chatroomId with userId: $userId",
        );
      }
    } catch (e) {
      debugPrint("Failed to view messages: $e");
      onError?.call("Failed to view messages");
    }
  }

  // Send message with connection check
  void sendMessage(Map<String, dynamic> message) {
    if (!isConnected) {
      debugPrint("Cannot send message: WebSocket not connected");
      return;
    }

    try {
      final encodedMessage = jsonEncode(message);
      _channel?.sink.add(encodedMessage);
      log("Message sent: $encodedMessage");
    } catch (e) {
      debugPrint("Failed to send message: $e");
      onError?.call("Failed to send message");
    }
  }

  // Manual reconnection
  void reconnect() {
    if (_socketUrl != null) {
      debugPrint("Manual reconnection initiated");
      disconnect();
      _reconnectAttempts = 0;

      // Small delay before reconnecting
      Timer(const Duration(milliseconds: 500), () {
        connect(_socketUrl!);
      });
    }
  }

  // Disconnect from socket
  void disconnect() {
    debugPrint("Disconnecting WebSocket...");

    _socketUrl = null; // Prevent automatic reconnection
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    try {
      _channel?.sink.close(1000, "Manual disconnect");
      _setConnectionStatus(ConnectionStatus.disconnected);
      log("WebSocket connection closed");
    } catch (e) {
      debugPrint("Error closing WebSocket: $e");
    }

    _channel = null;
    _reconnectAttempts = 0;
  }

  // Set callback functions
  void setOnMessageReceived(Function(String) callback) {
    onMessageReceived = callback;
  }

  void setOnConnectionStatusChanged(Function(ConnectionStatus) callback) {
    onConnectionStatusChanged = callback;
  }

  void setOnError(Function(String) callback) {
    onError = callback;
  }

  // Dispose method for proper cleanup
  void dispose() {
    disconnect();
    onMessageReceived = null;
    onConnectionStatusChanged = null;
    onError = null;
  }
}
