import 'package:clean_arc_first/features/data/models/vehicles.dart';
import 'package:clean_arc_first/features/domain/entities/home.dart';

class HomeModel extends HomeEntites {
  HomeModel({required super.vehicles});
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        vehicles: List<Vehicle>.from(
            json["vehicles"].map((x) => Vehicle.fromJson(x))));
  }
}
