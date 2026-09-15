class FavouriteItemsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<FavouriteItem> data;

  FavouriteItemsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  // Factory constructor to parse the JSON data
  factory FavouriteItemsResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteItemsResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => FavouriteItem.fromJson(item))
          .toList(),
    );
  }
}

class FavouriteItem {
  final String id;
  final Car car;

  FavouriteItem({required this.id, required this.car});

  // Factory constructor to parse the JSON data for each favourite item
  factory FavouriteItem.fromJson(Map<String, dynamic> json) {
    return FavouriteItem(id: json['id'], car: Car.fromJson(json['car']));
  }
}

class Car {
  final String id;
  final String carName;
  final String carModel;
  final String carLocation;
  final int registrationYear;
  final double price;
  final List<String> carImages;
  final int mileage;
  final double? discountPercent;
  final double? discountPrice;

  Car({
    required this.id,
    required this.carName,
    required this.carModel,
    required this.carLocation,
    required this.registrationYear,
    required this.price,
    required this.carImages,
    required this.mileage,
    this.discountPercent,
    this.discountPrice,
  });

  // Factory constructor to parse the JSON data for the car
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      carName: json['carName'],
      carModel: json['carModel'],
      carLocation: json['carLocation'],
      registrationYear: json['registrationYear'],
      price: json['price'].toDouble(),
      carImages: List<String>.from(json['carImages'] ?? []),
      mileage: json['mileage'],
      discountPercent: json['discountPercent']?.toDouble(),
      discountPrice: json['discountPrice']?.toDouble(),
    );
  }
}
