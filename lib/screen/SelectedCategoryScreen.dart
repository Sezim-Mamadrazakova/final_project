import 'package:flutter/material.dart';

import 'SelectedClothingItemScreen.dart';

class SelectCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCategoryCard(context, 'Вверх', 'Вверх'),
          _buildCategoryCard(context, 'Низ', 'Низ'),
          _buildCategoryCard(context, 'Обувь', 'Обувь'),
          _buildCategoryCard(context, 'Аксессуары', 'Аксессуары'),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String category) {
    return Card(
      color: Colors.grey[200], // Цвет карточки
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SelectClothingItemScreen(category: category),
            ),
          );
        },
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
