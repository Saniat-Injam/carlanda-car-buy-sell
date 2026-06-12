class TrackingOrderResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<TrackingOrder> data;

  TrackingOrderResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  // Factory constructor to parse the JSON data
  factory TrackingOrderResponse.fromJson(Map<String, dynamic> json) {
    return TrackingOrderResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => TrackingOrder.fromJson(item))
          .toList(),
    );
  }
}

class TrackingOrder {
  final String id;
  final String createdAt;
  final String trackingNumber;
  final String orderStatus;
  final String paymentStatus;
  final Car car;

  TrackingOrder({
    required this.id,
    required this.createdAt,
    required this.trackingNumber,
    required this.orderStatus,
    required this.paymentStatus,
    required this.car,
  });

  // Factory constructor to parse the JSON data for each tracking order
  factory TrackingOrder.fromJson(Map<String, dynamic> json) {
    return TrackingOrder(
      id: json['id'],
      createdAt: json['createdAt'],
      trackingNumber: json['trackingNumber'],
      orderStatus: json['orderStatus'],
      paymentStatus: json['paymentStatus'],
      car: Car.fromJson(json['car']),
    );
  }
}

class Car {
  final String id;
  final List<String> carImages;
  final String carName;
  final String carModel;
  final String carLocation;
  final int registrationYear;
  final int mileage;

  Car({
    required this.id,
    required this.carImages,
    required this.carName,
    required this.carModel,
    required this.carLocation,
    required this.registrationYear,
    required this.mileage,
  });

  // Factory constructor to parse the JSON data for the car
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      carImages: List<String>.from(json['carImages'] ?? []),
      carName: json['carName'],
      carModel: json['carModel'],
      carLocation: json['carLocation'],
      registrationYear: json['registrationYear'],
      mileage: json['mileage'],
    );
  }
}
