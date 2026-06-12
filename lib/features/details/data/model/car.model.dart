import 'dart:convert';

// To parse this JSON data, do
// final car = Car.fromJson(jsonString);

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  bool? success;
  int? statusCode;
  String? message;
  CarData? data;

  Car({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : CarData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class CarData {
  String? id;
  String? carName;
  String? carModel;
  String? carLocation;
  int? registrationYear;
  double? price;
  List<String>? carImages;
  int? mileage;
  String? fuelType;
  String? interiorColor;
  String? exteriorColor;
  int? numberOfCylinders;
  String? transmission;
  int? numberOfSeats;
  int? enginePower;
  double? shippingCost;
  double? customClearanceCost;
  String? description;
  int? quantity;
  dynamic discountPercent;
  dynamic discountPrice;
  Brand? brand;
  Category? category;

  CarData({
    this.id,
    this.carName,
    this.carModel,
    this.carLocation,
    this.registrationYear,
    this.price,
    this.carImages,
    this.mileage,
    this.fuelType,
    this.interiorColor,
    this.exteriorColor,
    this.numberOfCylinders,
    this.transmission,
    this.numberOfSeats,
    this.enginePower,
    this.shippingCost,
    this.customClearanceCost,
    this.description,
    this.quantity,
    this.discountPercent,
    this.discountPrice,
    this.brand,
    this.category,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
    id: json["id"],
    carName: json["carName"],
    carModel: json["carModel"],
    carLocation: json["carLocation"],
    registrationYear: json["registrationYear"],
    price: json["price"]?.toDouble(),
    carImages: json["carImages"] == null ? [] : List<String>.from(json["carImages"].map((x) => x)),
    mileage: json["mileage"],
    fuelType: json["fuelType"],
    interiorColor: json["interiorColor"],
    exteriorColor: json["exteriorColor"],
    numberOfCylinders: json["numberOfCylinders"],
    transmission: json["transmission"],
    numberOfSeats: json["numberOfSeats"],
    enginePower: json["enginePower"],
    shippingCost: json["shippingCost"]?.toDouble(),
    customClearanceCost: json["customClearanceCost"]?.toDouble(),
    description: json["description"],
    quantity: json["quantity"],
    discountPercent: json["discountPercent"],
    discountPrice: json["discountPrice"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "carName": carName,
    "carModel": carModel,
    "carLocation": carLocation,
    "registrationYear": registrationYear,
    "price": price,
    "carImages": carImages == null ? [] : List<dynamic>.from(carImages!.map((x) => x)),
    "mileage": mileage,
    "fuelType": fuelType,
    "interiorColor": interiorColor,
    "exteriorColor": exteriorColor,
    "numberOfCylinders": numberOfCylinders,
    "transmission": transmission,
    "numberOfSeats": numberOfSeats,
    "enginePower": enginePower,
    "shippingCost": shippingCost,
    "customClearanceCost": customClearanceCost,
    "description": description,
    "quantity": quantity,
    "discountPercent": discountPercent,
    "discountPrice": discountPrice,
    "brand": brand?.toJson(),
    "category": category?.toJson(),
  };
}

class Brand {
  String? brandName;

  Brand({
    this.brandName,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    brandName: json["brandName"],
  );

  Map<String, dynamic> toJson() => {
    "brandName": brandName,
  };
}

class Category {
  String? categoryName;

  Category({
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
  };
}
