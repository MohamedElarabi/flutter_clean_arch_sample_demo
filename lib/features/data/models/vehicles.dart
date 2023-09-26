import '../../domain/entities/vehicles.dart';

class Vehicle extends VehicleEntites {
  Vehicle({
    required super.id,
    required super.previewImage,
    required super.name,
    required super.brandName,
    required super.brandImage,
    required super.modelName,
    required super.status,
    required super.isFavorite,
    required super.isAsk,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        previewImage: json["preview_image"],
        name: json["name"],
        brandName: json["brand_name"],
        brandImage: json["brand_image"],
        modelName: json["model_name"],
        status: json["status"],
        isFavorite: json["is_favorite"],
        isAsk: json["is_ask"],
      );
}
