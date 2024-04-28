// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:calculate_dite/model/add_meal_model/add_meal_model.dart';

class ShowUserListModel {
  String? name;
  String? image;
  String? id;
  List<AddMealModel>? mealList;
  ShowUserListModel({
    this.name,
    this.image,
    this.id,
    this.mealList,
  });

  ShowUserListModel copyWith({
    String? name,
    String? image,
    String? id,
    List<AddMealModel>? mealList,
  }) {
    return ShowUserListModel(
      name: name ?? this.name,
      image: image ?? this.image,
      id: id ?? this.id,
      mealList: mealList ?? this.mealList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'id': id,
      'mealList': mealList?.map((x) => x.toMap()).toList(),
    };
  }

  factory ShowUserListModel.fromMap(Map<String, dynamic> map) {
    return ShowUserListModel(
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      mealList: map['mealList'] != null
          ? List<AddMealModel>.from(
              (map['mealList'] as List<int>).map<AddMealModel?>(
                (x) => AddMealModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowUserListModel.fromJson(String source) =>
      ShowUserListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShowUserListModel(name: $name, image: $image, id: $id, mealList: $mealList)';
  }

  @override
  bool operator ==(covariant ShowUserListModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        other.id == id &&
        listEquals(other.mealList, mealList);
  }

  @override
  int get hashCode {
    return name.hashCode ^ image.hashCode ^ id.hashCode ^ mealList.hashCode;
  }
}
