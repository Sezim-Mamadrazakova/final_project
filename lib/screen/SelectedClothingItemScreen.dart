import 'package:final_project/providers/ClothingItemsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/entity/ClothingItem.dart';



class SelectClothingItemScreen extends StatelessWidget {
  final String category;

  SelectClothingItemScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final clothingItemsProvider = Provider.of<ClothingItemsProvider>(context);
    final List<ClothingItem> clothingItems =
    clothingItemsProvider.filterItemsByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Clothing Item'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Количество элементов в строке
          mainAxisSpacing: 8.0, // Пространство между элементами по вертикали
          crossAxisSpacing: 8.0, // Пространство между элементами по горизонтали
          childAspectRatio: 0.75, // Соотношение сторон элемента
        ),
        itemCount: clothingItems.length,
        itemBuilder: (ctx, index) {
          final item = clothingItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop(item); // Return the selected item to the previous screen
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item.picture,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.picture,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.season as String,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
