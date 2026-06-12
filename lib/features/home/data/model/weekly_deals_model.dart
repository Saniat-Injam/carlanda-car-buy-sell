class WeeklyDealsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Deal> data;

  WeeklyDealsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory WeeklyDealsResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyDealsResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => Deal.fromJson(item))
          .toList(),
    );
  }
}

class Deal {
  final String id;
  final String carName;
  final List<String> carImages;

  Deal({
    required this.id,
    required this.carName,
    required this.carImages,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      carName: json['carName'],
      carImages: List<String>.from(json['carImages'] ?? []),
    );
  }
}
