import 'package:final_project/screen/SelectedCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/entity/ClothingItem.dart';
import '../data/entity/Outfit.dart';
import '../providers/OutfitProvider.dart';
import '../widget/ClothingItemWidget.dart';
import 'SelectedClothingItemScreen.dart';

class AddOutfitScreen extends StatefulWidget {
  @override
  _AddOutfitScreenState createState() => _AddOutfitScreenState();
}

class _AddOutfitScreenState extends State<AddOutfitScreen> {
  final List<ClothingItem> selectedItems = [];

  void _addItem(ClothingItem item) {
    setState(() {
      selectedItems.add(item);
    });
  }

  void _removeItem(ClothingItem item) {
    setState(() {
      selectedItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать аутфит'),
      ),
      body: Container(
        color: Colors.grey, // Устанавливаем серый цвет фона
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            color: Colors.white, // Устанавливаем белый цвет холста
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  // Здесь можно нарисовать специальный холст
                ),
                ListView.builder(
                  itemCount: selectedItems.length,
                  itemBuilder: (ctx, index) {
                    return ClothingItemWidget(
                      key: Key(selectedItems[index].idItem.toString()), // Присваиваем ключ на основе идентификатора вещи
                      clothingItem: selectedItems[index],
                      //onRemove: () => _removeItem(selectedItems[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to a screen to select clothing items
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectCategoryScreen()),
          );
          //final newItem = await Navigator.of(context).pushNamed<ClothingItem>('/select_clothing_item');
          if (newItem != null) {
            _addItem(newItem);
          }
        },
        child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Color.fromRGBO(232, 136, 46, 0.75)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Располагаем кнопку по центру внизу
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ButtonBar(
            alignment: MainAxisAlignment.center, // Выравниваем кнопку по центру
            children: [
        SizedBox(
        width: MediaQuery.of(context).size.width * 0.5, // Устанавливаем ширину кнопки
        child: ElevatedButton(
          onPressed: () {
            // Create an outfit from selected items
            Outfit outfit = Outfit(clothingItems: selectedItems, idOutfit: 1, idUser: '');
            Provider.of<OutfitProvider>(context, listen: false).addOutfit(outfit);
            Navigator.of(context).pop();
          },
          child: Text('Сохранить'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            textStyle: TextStyle(
                color: Colors.white), // Белый цвет текста на кнопке
          ),

            ),
        ),

    ])));
  }
}


