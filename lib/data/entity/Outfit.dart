import 'ClothingItem.dart';

class Outfit {
  final int idOutfit;
  final String idUser;
  final List<ClothingItem> clothingItems;

  Outfit.fromAdd(
       this.idOutfit, this.idUser, this.clothingItems
      );
  Outfit({
    required this.idOutfit,
    required this.idUser,
    required this.clothingItems,

  });
  Outfit.fromJson(Map<String, dynamic> json)
      : idOutfit = json['idOutfit'],
        idUser=json['idUser'],
        clothingItems = (json['clothingItems'] as List)
            .map((itemJson) => ClothingItem.fromJson(itemJson))
            .toList();

  // Метод для преобразования объекта Outfit в формат JSON
  Map<String, dynamic> toJson() => {
    'idOutfit': idOutfit,
    'idUser': idUser,
    'clothingItems': clothingItems.map((item) => item.toJson()).toList(),
  };

}