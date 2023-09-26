import 'package:clean_arc_first/features/domain/entities/login.dart';

class UserModel extends Login {
  UserModel({required super.id, required super.fullName, required super.image});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"], fullName: json["full_name"], image: json["avatar"] ?? "");
}
