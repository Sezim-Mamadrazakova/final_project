import 'dart:convert';
import 'dart:io';
import 'package:final_project/enums/Season.dart';
import 'package:flutter/material.dart';
import 'package:final_project/enums/Category.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../data/entity/ClothingItem.dart';

class ClothingItemsProvider with ChangeNotifier {
  List<ClothingItem> _items = [];

  List<ClothingItem> get items {
    return [..._items];
  }

  get clothingItems => null;

  ClothingItem findById(int id) {
    return _items.firstWhere((item) => item.idItem == id);
  }

  List<ClothingItem> filterItemsBySeason(Season season) {
    return _items.where((item) => item.season == season).toList();
  }

  List<ClothingItem> filterItemsByColor(Color color) {
    return _items.where((item) => item.color == color).toList();
  }

  List<ClothingItem> filterItemsByCategory(String category) {
    return _items.where((item) => item.category == category).toList();
  }

  Future<void> fetchAndSetItems() async {
    final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/clothingItems.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return;
      }
      final List<ClothingItem> loadedItems = [];
      extractedData.forEach((itemId, itemData) {
        loadedItems.add(ClothingItem(
          idItem: int.parse(itemId),
          picture: itemData['picture'],
          category: itemData['category'],
          color: itemData['color'],
          season: itemData['season'],
          idUser: itemData['idUser'],
        ));
      });
      _items = loadedItems;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addItem(ClothingItem item) async {
    final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/clothingItems.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'picture': item.picture,
          'category': item.category,
          'color': item.color,
          'season': item.season,
          'idUser': item.idUser,
        }),
      );
      print(json.decode(response.body));
      final newItem = ClothingItem(
        idItem: int.parse(json.decode(response.body)['id']),
        picture: item.picture,
        category: item.category,
        color: item.color,
        season: item.season,
        idUser: item.idUser,
      );
      _items.add(newItem);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteItem(int id) async {
    final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/clothingItems/$id.json');
    final existingItemIndex = _items.indexWhere((item) => item.idItem == id);
    ClothingItem? existingItem = _items[existingItemIndex];
    _items.removeAt(existingItemIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw HttpException('Could not delete item.');
    } else {
      existingItem = null;
    }
  }
  Future<void> editItem(ClothingItem newItem) async {
    final itemIndex = _items.indexWhere((item) => item.idItem == newItem.idItem);
    if (itemIndex >= 0) {
      final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/clothingItems/${newItem.idItem}.json');
      await http.patch(
        url,
        body: json.encode({
          'picture': newItem.picture,
          'category': newItem.category,
          'color': newItem.color,
          'season': newItem.season,
          'idUser': newItem.idUser,
        }),
      );
      _items[itemIndex] = newItem;
      notifyListeners();
    }
  }


}
