
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:final_project/data/entity/ClothingItem.dart';
import 'package:final_project/data/entity/Outfit.dart';
import 'package:flutter/cupertino.dart';

class OutfitProvider with ChangeNotifier{
  List<Outfit> _outfits = [];

  List<Outfit> get outfits => _outfits;

  Future<void> loadOutfits() async {
    final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/outfits.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<Outfit> loadedOutfits = [];
      if (extractedData != null) {
        extractedData.forEach((outfitId, outfitData) {
          loadedOutfits.add(Outfit.fromJson({
            ...outfitData,
            'idOutfit': int.parse(outfitId),
          }));
        });
        _outfits = loadedOutfits;
        notifyListeners();
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOutfit(Outfit outfit) async {
    final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/outfits.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'idUser': outfit.idUser,
          'clothingItems': outfit.clothingItems.map((item) => item.toJson()).toList(),
        }),
      );
      print(json.decode(response.body));
      final newOutfit = Outfit(
        idOutfit: int.parse(json.decode(response.body)['name']),
        idUser: outfit.idUser,
        clothingItems: outfit.clothingItems,
      );
      _outfits.add(newOutfit);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void removeOutfit(int index) {
    final url = Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/outfits/${_outfits[index].idOutfit}.json');
    try {
      http.delete(url);
      _outfits.removeAt(index);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }



}