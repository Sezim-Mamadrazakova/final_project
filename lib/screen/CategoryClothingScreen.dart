import 'package:final_project/widget/ClothingItemWidget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../data/entity/ClothingItem.dart';
import '../enums/Category.dart';
import '../providers/ClothingItemsProvider.dart';


class CategoryClothingScreen extends StatelessWidget {
  final String category;

  CategoryClothingScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final List<ClothingItem> clothingItems = Provider.of<ClothingItemsProvider>(context)
        .filterItemsByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category), // Заголовок экрана - имя выбранной категории
        leading: IconButton(
          icon: Icon(Icons.filter_list), // Иконка фильтрации
          onPressed: () {
            // Действие при нажатии на иконку фильтрации
            // Например, открытие диалога для выбора параметров фильтрации
          },
        ),
      ),
      body: ClothingGrid(clothingItems: clothingItems),
    );
  }
}

class ClothingGrid extends StatelessWidget {
  final List<ClothingItem> clothingItems;

  ClothingGrid({required this.clothingItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: clothingItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 столбца в сетке
        childAspectRatio: 3 / 4, // Соотношение сторон каждого элемента сетки
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            // Навигация к экрану с подробной информацией о выбранной вещи
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ClothingItemWidget(key: UniqueKey(), clothingItem: clothingItems[index]),
              ),
            );
          },
          child: GridTile(
            child: Image.network(
              clothingItems[index].picture, // Изображение вещи
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
