class CarModel {
  final String? id;
  final String? carName;
  final String? carModel;
  final String? carLocation;
  final int? registrationYear;
  final int? price;
  final List<String>? carImages;
  final int? mileage;
  final double? discountPercent;
  final int? discountPrice;

  CarModel({
    this.id,
    this.carName,
    this.carModel,
    this.carLocation,
    this.registrationYear,
    this.price,
    this.carImages,
    this.mileage,
    this.discountPercent,
    this.discountPrice,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      carName: json['carName'],
      carModel: json['carModel'],
      carLocation: json['carLocation'],
      registrationYear: json['registrationYear'],
      price: json['price'],
      carImages: json['carImages'] != null
          ? List<String>.from(json['carImages'])
          : [],
      mileage: json['mileage'],
      discountPercent: json['discountPercent']?.toDouble(),
      discountPrice: json['discountPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carName': carName,
      'carModel': carModel,
      'carLocation': carLocation,
      'registrationYear': registrationYear,
      'price': price,
      'carImages': carImages,
      'mileage': mileage,
      'discountPercent': discountPercent,
      'discountPrice': discountPrice,
    };
  }

  // Helper method to get display price
  int get displayPrice => discountPrice ?? price ?? 0;

  // Helper method to check if has discount
  bool get hasDiscount => discountPrice != null && discountPercent != null;

  // Helper method to get first image or placeholder
  String get primaryImage =>
      (carImages != null && carImages!.isNotEmpty)
          ? carImages!.first
          : '';

  @override
  String toString() {
    return 'CarModel(id: $id, carName: $carName, carModel: $carModel, location: $carLocation)';
  }
}

class CarResponseModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final CarDataModel? data;

  CarResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CarResponseModel.fromJson(Map<String, dynamic> json) {
    return CarResponseModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? CarDataModel.fromJson(json['data'])
          : null,
    );
  }
}

class CarDataModel {
  final MetaModel? meta;
  final List<CarModel>? data;

  CarDataModel({
    this.meta,
    this.data,
  });

  factory CarDataModel.fromJson(Map<String, dynamic> json) {
    return CarDataModel(
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'])
          : null,
      data: json['data'] != null
          ? List<CarModel>.from(
          json['data'].map((car) => CarModel.fromJson(car))
      )
          : [],
    );
  }
}

class MetaModel {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  MetaModel({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPages': totalPages,
    };
  }
}

