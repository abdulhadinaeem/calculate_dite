// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddMealModel {
  String? mealImage;
  String? mealName;
  String? mealCalories;
  String? userId;
  AddMealModel({
    this.mealImage,
    this.mealName,
    this.mealCalories,
    this.userId,
  });

  AddMealModel copyWith({
    String? mealImage,
    String? mealName,
    String? mealCalories,
    String? userId,
  }) {
    return AddMealModel(
      mealImage: mealImage ?? this.mealImage,
      mealName: mealName ?? this.mealName,
      mealCalories: mealCalories ?? this.mealCalories,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mealImage': mealImage,
      'mealName': mealName,
      'mealCalories': mealCalories,
      'userId': userId,
    };
  }

  factory AddMealModel.fromMap(Map<String, dynamic> map) {
    return AddMealModel(
      mealImage: map['mealImage'] != null ? map['mealImage'] as String : null,
      mealName: map['mealName'] != null ? map['mealName'] as String : null,
      mealCalories:
          map['mealCalories'] != null ? map['mealCalories'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddMealModel.fromJson(String source) =>
      AddMealModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddMealModel(mealImage: $mealImage, mealName: $mealName, mealCalories: $mealCalories, userId: $userId)';
  }

  @override
  bool operator ==(covariant AddMealModel other) {
    if (identical(this, other)) return true;

    return other.mealImage == mealImage &&
        other.mealName == mealName &&
        other.mealCalories == mealCalories &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return mealImage.hashCode ^
        mealName.hashCode ^
        mealCalories.hashCode ^
        userId.hashCode;
  }
}
