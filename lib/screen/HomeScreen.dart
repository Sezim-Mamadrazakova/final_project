import 'dart:js';

import 'package:final_project/screen/AddItemScreen.dart';
import 'package:final_project/screen/OutfitScreen.dart';
import 'package:flutter/material.dart';
import 'CategoryClothingScreen.dart';
import '../data/entity/ClothingItem.dart';
import 'SelectedClothingItemScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //get category => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Твой шкаф'),
        actions: [
          // Замените на свою иконку пользователя и никнейм
          IconButton(
            onPressed: () {
              // Обработка нажатия на иконку пользователя
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2, // 2 колонки для категорий одежды
        children: [
          // Замените на свои категории одежды
          _buildCategoryCard('Вверх', Icons.accessibility),
          _buildCategoryCard('Низ', Icons.accessibility),
          _buildCategoryCard('Обувь', Icons.accessibility),
          _buildCategoryCard('Аксессуары', Icons.accessibility),
        ],
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
            SizedBox(),
            // IconButton(
            //   onPressed: () {
            //     // Обработка нажатия на иконку плюсика
            //     // Переход на экран RemoveBackground
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AddItemScreen()),
            //     );
            //   },
            //   icon: const Icon(Icons.add),
            // ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Обработка нажатия на новый плюсик
          // Переход на экран RemoveBackground
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        backgroundColor: Color.fromRGBO(232, 136, 46, 0.75), // RGB цвет с прозрачностью
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );




  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Card(
        color: Color.fromRGBO(238, 169, 119, 0.14),
        child: InkWell(
          onTap: () {
            Navigator.of(context as BuildContext).push(
            MaterialPageRoute(
            builder: (_) => CategoryClothingScreen(category: title),
            ),
            );
    },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    ));
  }
}
