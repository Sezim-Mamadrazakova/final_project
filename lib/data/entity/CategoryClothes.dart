import 'package:final_project/enums/Category.dart';

import 'ClothingItem.dart';

class CategoryClothes{
  int idCategory;
  Category category;
  List<ClothingItem> clothingItemsList;

  CategoryClothes(this.idCategory, this.category, this.clothingItemsList);
  factory CategoryClothes.fromJson(Map<String, dynamic> json) {
    return CategoryClothes(
      json['idCategory'] as int,
      json['category'] as Category,
      (json['clothingItemsList'] as List)
          .map((item) => ClothingItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': idCategory,
      'category': category.toString(),
      'clothingItemsList': clothingItemsList.map((item) => item.toJson()).toList(),
    };
  }
}