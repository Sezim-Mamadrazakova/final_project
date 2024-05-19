import 'dart:typed_data';

import 'package:final_project/screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../data/entity/ClothingItem.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../data/entity/ClothingItem.dart';
//import '../data/model/User.dart';
import '../enums/Category.dart';
import '../enums/Season.dart';
import '../providers/ClothingItemsProvider.dart';
import 'ApiClient.dart';

import 'package:flutter/material.dart';

import 'CategoryClothingScreen.dart';


//экран для добавления вещи
class AddItemScreen extends StatefulWidget {


  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  //User? user = FirebaseAuth.instance.currentUser;
  Uint8List? imageFile;
  String? imagePath;
  ScreenshotController controller = ScreenshotController();

  // Переменные для хранения выбранных значений из выпадающих списков
  String? selectedCategory;
  String? selectedSeason;
  String? selectedColor;

  // Списки значений для выпадающих списков
  List<String> categories = ['Вверх', 'Низ', 'Обувь', 'Аксессуары'];
  List<String> seasons = ['Весна', 'Лето', 'Осень', 'Зима'];
  List<String> colors = ['Красный', 'Синий', 'Зеленый', 'Желтый', 'Чёрный', 'Серый', 'Коричневый', 'Оранжевый', 'Белый', 'Розовый', 'Фиолетовый'];

  List<ClothingItem>? get clothingItems => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.image)),
          IconButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              icon: const Icon(Icons.camera_alt)),
          IconButton(
              onPressed: () async {
                imageFile = await ApiClient().removeBgApi(imagePath!);
                setState(() {});
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () async {
                saveImage();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (imageFile != null)
                ? Screenshot(
                    controller: controller,
                    child: Image.memory(
                      imageFile!,
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                    child: const Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
            // Добавление выпадающих списков
            DropdownButton<String>(
              hint: Text('Выберите категорию'),
              value: selectedCategory,
              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              hint: Text('Выберите сезон'),
              value: selectedSeason,
              onChanged: (String? value) {
                setState(() {
                  selectedSeason = value;
                });
              },
              items: seasons.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              hint: Text('Выберите цвет'),
              value: selectedColor,
              onChanged: (String? value) {
                setState(() {
                  selectedColor = value;
                });
              },
              items: colors.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Сохранение изображения
            ElevatedButton(
              onPressed: () {
                saveImage();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Сохранить'),
            ),
            // Отображение загруженного изображения
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile = await pickedImage.readAsBytes();
        setState(() {});
      }
    } catch (e) {
      imageFile = null;
      setState(() {});
    }
  }

  void saveImage() async {
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }

    if (isGranted) {
      String directory = (await getExternalStorageDirectory())!.path;
      String fileName =
          DateTime.now().microsecondsSinceEpoch.toString() + ".png";
      controller.captureAndSave(directory, fileName: fileName);
    }
    String directory = (await getExternalStorageDirectory())!.path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString() + ".png";

    // Создаем объект ClothingItem
    ClothingItem newItem = ClothingItem(
      idItem: DateTime.now()
          .millisecondsSinceEpoch, // Используем уникальный идентификатор для idItem
      picture: '$directory/$fileName', // Путь к сохраненному изображению
      category: getCategoryFromString(selectedCategory!),
      color: getColorFromString(selectedColor!),
      season: getSeasonFromString(selectedSeason!),
      idUser: 'dtrdr',
    );

    // Добавляем новый элемент в ClothingItems
    Provider.of<ClothingItemsProvider>(context, listen: false).addItem(newItem);

    // Вызов метода fetchAndSetItems для обновления списка элементов
    //await ClothingItems().fetchAndSetItems();
    // Перенаправляем пользователя на новый экран, передавая новый элемент одежды
    // Navigator.push(
    //   context,
    //MaterialPageRoute(builder: (context) => ClothingItemScreen(newItem));
    // );
  }

  Category getCategoryFromString(String categoryName) {
    switch (categoryName) {
      case 'Вверх':
        return Category.top;
      case 'Низ':
        return Category.bottom;
      case 'Обувь':
        return Category.footwear;
      case 'Аксессуары':
        return Category.accessories;
      default:
        return Category.other; // Обработайте другие случаи по вашему усмотрению
    }
  }

  Season getSeasonFromString(String seasonName) {
    switch (seasonName) {
      case 'Весна':
        return Season.spring;
      case 'Лето':
        return Season.summer;
      case 'Осень':
        return Season.autumn;
      case 'Зима':
        return Season.winter;
      default:
        return Season.other; // Обработайте другие случаи по вашему усмотрению
    }
  }

  Color getColorFromString(String colorName) {
    switch (colorName) {
      case 'Красный':
        return Colors.red;
      case 'Синий':
        return Colors.blue;
      case 'Зеленый':
        return Colors.green;
      case 'Желтый':
        return Colors.yellow;
      case 'Чёрный':
        return Colors.black;
      // Добавьте другие цвета по вашему усмотрению
      default:
        return Colors.black; // Цвет по умолчанию для неопределенных значений
    }
  }
}
