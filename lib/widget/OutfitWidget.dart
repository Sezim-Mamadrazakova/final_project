import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/entity/Outfit.dart';


class OutfitWidget extends StatelessWidget {
  final Outfit outfit;

  OutfitWidget({Key? key, required this.outfit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      child: Card(
        elevation: 6,
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Отобразить изображения одежды из объекта outfit
                  for (var clothingItem in outfit.clothingItems)
                    Image.network(
                      clothingItem.picture,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.3,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Обработка нажатия на карточку аутфита
        // Здесь можно добавить код для перехода к деталям аутфита
      },
    );
  }
}

