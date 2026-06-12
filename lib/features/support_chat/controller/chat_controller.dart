import 'dart:convert';
import 'dart:developer';
import 'package:carlanda_car_buy_sell/core/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final WebSocketClient socketClient = WebSocketClient();

  Rx<ConnectionStatus> connectionStatus = ConnectionStatus.disconnected.obs;
  RxBool isConnectionLost = false.obs;

  final List<Map<String, dynamic>> _pendingMessages = [];

  @override
  void onInit() {
    super.onInit();
    // _initializeWebSocket()
    _addMessageToUI(
      messageId: "tempId1",
      content: "Welcome to CarLanda!  How can I help you?",
      senderId: "AuthService.userID" ?? "",
      conversationId: roomId.value,
      isRead: false,
      updatedAt: DateTime.now().toIso8601String(),
      imageUrls: "",
      localImagePath: "",
      status: 'sending',
      isTemporary: true,
    );

    _addMessageToUI(
      messageId: "tempId2",
      content: "I want to know a car details Please help me .",
      senderId: "",
      conversationId: roomId.value,
      isRead: false,
      updatedAt: DateTime.now().toIso8601String(),
      imageUrls: "",
      localImagePath: "",
      status: 'sent',
      isTemporary: true,
    );
  }

  void _initializeWebSocket() {
    socketClient.setOnConnectionStatusChanged((status) {
      connectionStatus.value = status;
      switch (status) {
        case ConnectionStatus.connected:
          isConnectionLost.value = false;
          _processPendingMessages();
          break;
        case ConnectionStatus.disconnected:
        case ConnectionStatus.reconnecting:
          isConnectionLost.value = true;
          break;
        case ConnectionStatus.connecting:
          break;
      }

      log("WebSocket connection status changed: $status");
    });

    socketClient.setOnError((error) {
      log("WebSocket error: $error");
    });

    socketClient.setOnMessageReceived((message) async {
      log("Raw WebSocket Message Received: $message");
      _handleIncomingMessage(message);
      isLoading.value = false;
    });

    socketClient.connect("");
  }

  void _processPendingMessages() {
    if (_pendingMessages.isNotEmpty) {
      log("Processing ${_pendingMessages.length} pending messages");

      for (final message in _pendingMessages) {
        socketClient.sendMessage(message);
      }

      _pendingMessages.clear();
    }
  }

  var messages = <Map<String, dynamic>>[].obs;
  RxBool showAttuchIcon = true.obs;
  RxString selectedImage = "".obs;
  RxString roomId = "".obs;
  RxString generatedImageLink = "".obs;
  RxBool isLoading = false.obs;

  showSendbox() {
    if (textController.text.isEmpty) {
      showAttuchIcon.value = true;
    } else {
      showAttuchIcon.value = false;
    }
  }

  Future<void> createChatRoom({required String user2Id}) async {
    isLoading.value = true;
    final userId = "AuthService.userID";

    if (socketClient.isConnected) {
      socketClient.joinRoom(userId, user2Id);
    } else {
      log("Cannot join room: WebSocket not connected");
      isLoading.value = false;
    }
  }

  Future<void> sendMessage({
    required String message,
    required String reciverId,
    String? localImagePath,
  }) async {
    if (message.isEmpty && (localImagePath == null || localImagePath.isEmpty)) {
      return;
    }

    try {
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final currentTime = DateTime.now().toIso8601String();

      _addMessageToUI(
        messageId: tempId,
        content: message,
        senderId: "",
        conversationId: roomId.value,
        isRead: false,
        updatedAt: currentTime,
        imageUrls: "",
        localImagePath: localImagePath,
        status: 'sending',
        isTemporary: true,
      );

      String? uploadedImageUrl;

      if (localImagePath != null && localImagePath.isNotEmpty) {
        log("Starting image upload process...");

        log("Image upload result: $uploadedImageUrl");

        final messageIndex = messages.indexWhere((msg) => msg['id'] == tempId);
        if (messageIndex != -1) {
          messages[messageIndex]['sentStatus'] = 'failed';
          log("Image upload failed, updating message status to failed");
          messages.refresh();
        }
      }

      final Map<String, dynamic> messageBody = {
        "type": "sendMessage",
        "chatroomId": roomId.value,
        "senderId": " AuthService.userID",
        "receiverId": reciverId,
        "content": message,
        "file": uploadedImageUrl ?? "",
      };

      if (socketClient.isConnected) {
        log("Sending message via WebSocket: $messageBody");
        socketClient.sendMessage(messageBody);
      } else {
        log("WebSocket disconnected, queuing message");
        _pendingMessages.add(messageBody);

        final messageIndex = messages.indexWhere((msg) => msg['id'] == tempId);
        if (messageIndex != -1) {
          messages[messageIndex]['sentStatus'] = 'queued';
          messages.refresh();
        }
      }
    } catch (e) {
      log("Something went wrong in sendMessage, error: $e");
      final failedMessageIndex = messages.indexWhere(
        (msg) =>
            msg['isTemporary'] == true &&
            msg['content'] == message &&
            msg['sentStatus'] == 'sending',
      );

      if (failedMessageIndex != -1) {
        messages[failedMessageIndex]['sentStatus'] = 'failed';
        messages.refresh();
      }
    }
  }

  void viewMessage() {
    log("View Message Called");
    String id = "AuthService.userID.toString()";

    if (socketClient.isConnected) {
      socketClient.viewMessage(roomId.value, id);
    } else {
      log("Cannot view messages: WebSocket not connected");
    }
  }

  void updateMessageStatus(int index, String status) {
    if (index >= 0 && index < messages.length) {
      messages[index]['sentStatus'] = status;
      messages.refresh();
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image.path;
      log("Selected image path: ${image.path}");
    }
  }

  // Manual reconnection method
  void reconnectWebSocket() {
    log("Manual WebSocket reconnection initiated");
    socketClient.reconnect();
  }

  // Get connection status text for UI
  String getConnectionStatusText() {
    switch (connectionStatus.value) {
      case ConnectionStatus.connected:
        return "Connected";
      case ConnectionStatus.connecting:
        return "Connecting...";
      case ConnectionStatus.reconnecting:
        return "Reconnecting...";
      case ConnectionStatus.disconnected:
        return "Disconnected";
    }
  }

  void _handleIncomingMessage(String rawMessage) {
    try {
      final decodedMessage = jsonDecode(rawMessage);
      log("Decoded WebSocket Message: $decodedMessage");

      final String? type = decodedMessage['type'];

      if (type == null) {
        log("Invalid message: missing type");
        return;
      }

      if (type == 'loadMessages') {
        final conversation = decodedMessage['conversation'];
        if (conversation != null && conversation['id'] != null) {
          roomId.value = conversation['id'];
          log("Loaded conversation ID: ${conversation['id']}");
          messages.clear();

          final List<dynamic> msgList = conversation['messages'] ?? [];

          for (var msg in msgList) {
            _addMessageToUI(
              messageId: msg['id'] ?? '',
              content: msg['content'] ?? '',
              senderId: msg['senderId'] ?? '',
              conversationId: msg['conversationId'] ?? '',
              isRead: msg['isRead'] ?? false,
              updatedAt: msg['updatedAt'] ?? '',
              imageUrls: msg['file'] ?? '',
              status: 'sent',
              isTemporary: false,
            );
          }
        }
      } else if (type == 'receiveMessage' || type == 'messageSent') {
        final message = decodedMessage['message'];
        if (message != null) {
          final senderId = message['senderId'];
          final currentUserId = "AuthService.userID";

          // Check if this is our own message (confirmation) or from another user
          if (senderId == currentUserId) {
            // This is confirmation for our sent message
            _handleMessageConfirmation(message);
          } else {
            // This is a message from another user
            _addMessageToUI(
              messageId: message['id'] ?? '',
              content: message['content'] ?? '',
              senderId: message['senderId'] ?? '',
              conversationId: message['conversationId'] ?? '',
              isRead: message['isRead'] ?? false,
              updatedAt: message['updatedAt'] ?? '',
              imageUrls: message['file'] ?? '',
              status: 'sent',
              isTemporary: false,
            );
          }
        }
      } else {
        log("Unhandled message type: $type");
      }
    } catch (e, stack) {
      log("Error handling message: $e");
      log("StackTrace: $stack");
    }
  }

  void _addMessageToUI({
    required String messageId,
    required String content,
    required String senderId,
    required String conversationId,
    required bool isRead,
    required String updatedAt,
    required String imageUrls,
    required String status,
    required bool isTemporary,
    String? localImagePath,
  }) {
    // Check for duplicates
    final isDuplicate = messages.any((msg) => msg['id'] == messageId);
    if (isDuplicate) {
      debugPrint("Duplicate message ignored: $messageId from $senderId");
      return;
    }

    messages.add({
      'id': messageId,
      'content': content,
      'senderId': senderId,
      'conversationId': conversationId,
      'isRead': isRead,
      'updatedAt': updatedAt,
      'file': imageUrls,
      'localImagePath': localImagePath,
      'sentStatus': status,
      'isTemporary': isTemporary,
    });

    debugPrint(
      "Added message: $messageId | content: $content | from: $senderId | status: $status | file: $imageUrls",
    );
  }

  void _handleMessageConfirmation(Map<String, dynamic> serverMessage) {
    // Find the temporary message that matches this confirmation
    final tempMessageIndex = messages.indexWhere(
      (msg) =>
          msg['isTemporary'] == true &&
          msg['senderId'] == "AuthService.userID " &&
          msg['content'] == serverMessage['content'],
    );

    if (tempMessageIndex != -1) {
      // Update the existing temporary message with server data
      messages[tempMessageIndex] = {
        'id': serverMessage['id'], // Use real server ID
        'content': serverMessage['content'],
        'senderId': serverMessage['senderId'],
        'conversationId': serverMessage['conversationId'],
        'isRead': serverMessage['isRead'],
        'updatedAt': serverMessage['updatedAt'],
        'file': serverMessage['file'] ?? "",
        'localImagePath': null,
        'sentStatus': 'sent',
        'isTemporary': false,
      };

      messages.refresh();
      debugPrint(
        "Updated message status from 'sending' to 'sent': ${serverMessage['content']}",
      );
    } else {
      debugPrint(
        "No matching temporary message found for: ${serverMessage['content']}",
      );
    }
  }

  @override
  void onClose() {
    textController.dispose();
    socketClient.dispose();

    super.onClose();
  }
}
