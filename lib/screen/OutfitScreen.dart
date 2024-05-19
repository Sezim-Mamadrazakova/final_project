import 'package:final_project/screen/AddOutfitScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/providers/OutfitProvider.dart';

import '../widget/OutfitWidget.dart';
import 'HomeScreen.dart'; // Импортируем провайдер
//import 'package:final_project/widgets/OutfitWidget.dart'; // Импортируем OutfitWidget

class OutfitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем экземпляр OutfitProvider из контекста
    final outfitProvider = Provider.of<OutfitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Outfits'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: outfitProvider.outfits.length,
        itemBuilder: (context, index) {
          final outfit = outfitProvider.outfits[index];
          return GestureDetector(
            onTap: () {
              // Навигация к странице с подробной информацией об аутфите
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OutfitWidget(outfit: outfit, key: null),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                      itemCount: outfit.clothingItems.length,
                      itemBuilder: (context, itemIndex) {
                        // Вместо Image.network выводите соответствующую одежду
                        return Image.network(outfit.clothingItems[itemIndex] as String);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> HomeScreen()),
                );
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // Обработка нажатия на иконку плюсика
                // Переход на экран RemoveBackground
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddOutfitScreen()),
                );
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> OutfitScreen()),
                );
                //RemoveBackground
                // Обработка нажатия на иконку шкафа
              },
              icon: const Icon(Icons.shopping_bag),
            ),
          ],
        ),
      ),
    );
  }
}
