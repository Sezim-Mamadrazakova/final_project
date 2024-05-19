import 'package:final_project/enums/Category.dart';
import 'package:final_project/enums/Season.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/entity/ClothingItem.dart';
import '../providers/ClothingItemsProvider.dart';
//import '../data/model/ClothingItem.dart';

class ClothingItemWidget extends StatelessWidget {
  final ClothingItem clothingItem;

  ClothingItemWidget({required Key key, required this.clothingItem});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Действие при нажатии на карточку, например, переход на страницу деталей
      },
      child: Card(
        elevation: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Виджет для отображения изображения одежды
            Container(
              height: 200, // Высота изображения
              width: double.infinity, // Ширина изображения (заполняет всю доступную ширину)
              child: (clothingItem.picture != null)
                  ? Image.network(
                clothingItem.picture,
                fit: BoxFit.cover, // Растягивает изображение на всю область
              )
                  : Placeholder(
                fallbackHeight: 200.0,
                fallbackWidth: double.infinity,
              ),
            ),
            // Название категории (например, верхняя одежда, обувь и т.д.)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                clothingItem.category.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Цвет одежды
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Color: ${clothingItem.color}'),
            ),
            // Сезон, для которого подходит одежда
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Season: ${clothingItem.season}'),
            ),
          ],
        ),
      ),
    );
  }
}

class ClothingItemsGrid extends StatelessWidget {
  late User? user;
  late final List<ClothingItem> clothingItems;

  ClothingItemsGrid(this.clothingItems) {
    user = FirebaseAuth.instance.currentUser;
    clothingItems = [
      ClothingItem(
        picture: 'https://ae04.alicdn.com/kf/S0fd1ba11ebd24dc7bfbed9e2fce0b3319.jpg_480x480.jpg',
        category: Category.top,
        season: Season.autumn,
        color: Colors.amberAccent,
        idItem: 1,
        idUser: user!.uid,
      ),
      ClothingItem(
        picture: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqfehZTMGniaVB24tH8lSjiY5yX2v5FDY-3g&s',
        category: Category.top,
        season: Season.autumn,
        color: Colors.blue,
        idItem: 2,
        idUser: user!.uid,
      ),
      ClothingItem(
        picture: 'https://st1.tsum.com/sig/ad1da082b8fc04336266c4e1e2a75732/width/1526/i/b3/fb/0b/ed/b3fb0bed-dae8-37be-ae91-05690a7beeb1.jpg',
        category: Category.top,
        season: Season.spring,
        color: Colors.blue,
        idItem: 3,
        idUser: user!.uid,
      ),
      ClothingItem(
        picture: 'https://static.zara.net/assets/public/2537/74ca/79ea400e9d2b/e7d58f180cba/08614511066-e1/08614511066-e1.jpg?ts=1704818278597&w=824',
        category: Category.top,
        season: Season.winter,
        color: Colors.pinkAccent,
        idItem: 4,
        idUser: user!.uid,
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothing Grid'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 4, // Измените соотношение сторон по своему вкусу
        ),
        itemCount: clothingItems.length,
        itemBuilder: (ctx, index) => Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              Image.network(
                clothingItems[index].picture,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Category: ${clothingItems[index].category}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Season: ${clothingItems[index].season}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Color: ${clothingItems[index].color}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
