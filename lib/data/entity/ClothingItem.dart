import 'package:final_project/enums/Season.dart';
import 'package:final_project/enums/Category.dart';
import 'package:flutter/material.dart';

class ClothingItem  {
  final int idItem;
  final String picture;
  final Category category;
  final Color color;
  final Season season;
  final String idUser;

  ClothingItem({
    required this.idItem,
    required this.picture,
    required this.category,
    required this.color,
    required this.season,
    required this.idUser

  });
  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      idItem: json['idItem'],
      picture: json['picture'],
      category: json['category'],
      color: json['color'],
      season: json['season'],
      idUser: json['idUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idItem': idItem,
      'picture': picture,
      'category': category.toString(),
      'color': color.toString(),
      'season': season.toString(),
      'idUser': idUser.toString(),
    };
  }
  @override
  String toString() {
    return 'ClothingItem{idItem: $idItem, picture: $picture, category: $category, color: $color, season: $season, idUser: $idUser}';
  }
}
