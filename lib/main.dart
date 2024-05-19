import 'package:final_project/providers/ClothingItemsProvider.dart';
import 'package:final_project/providers/OutfitProvider.dart';
import 'package:final_project/screen/AddItemScreen.dart';
import 'package:final_project/screen/AddOutfitScreen.dart';
import 'package:final_project/screen/CategoryClothingScreen.dart';
import 'package:final_project/screen/HomeScreen.dart';
import 'package:final_project/screen/OutfitScreen.dart';
import 'package:final_project/widget/ClothingItemWidget.dart';
//import 'package:final_project/screen/AddItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screen/AuthScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClothingItemsProvider()),
        ChangeNotifierProvider(
            create: (_) => OutfitProvider()), // Предоставление ClothingItems
        // Добавьте другие провайдеры, если необходимо
      ],
      child: MaterialApp(
          title: 'Your App',
          home: OutfitScreen()//CategoryClothingScreen(category: 'Верх',)//const HomeScreen()
              //AuthScreen() //AddItemScreen() //OutfitScreen() //ClothingItemsGrid(),
          // Остальные настройки MaterialApp
          // initialRoute: '/', // Установка начального маршрута, если нужно
          // routes: {
          //   '/': (ctx) =>
          //   const HomeScreen(), //const HomeScreen(), // Пример маршрута на вашу домашнюю страницу
          //CategoryClothingScreen.routeName: (ctx) => CategoryClothingScreen(),
          // Добавьте другие маршруты, если необходимо
          //},
          ),
    );
  }
}
