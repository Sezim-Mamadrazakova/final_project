// // Функция для получения списка элементов одежды из сети
// import 'dart:convert';
//
// import '../model/CategoryClothes.dart';
// import '../model/ClothingItem.dart';
// import 'package:http/http.dart' as http;
//
// import '../model/Outfit.dart';
// Future<List<ClothingItem>> fetchClothingItems() async {
//   final response = await http.get(Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/clothingItems.json')); //
//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((item) => ClothingItem.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load clothing items');
//   }
// }
//
// // Функция для создания нового элемента одежды
// Future<void> createClothingItem(ClothingItem newItem) async {
//   final response = await http.post(
//     Uri.parse('https://wardrobefinal-default-rtdb.firebaseio.com/clothingItems.json'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(newItem.toJson()),
//   );
//   if (response.statusCode != 201) {
//     throw Exception('Failed to create clothing item');
//   }
// }
//
// // Функция для удаления элемента одежды
// Future<void> deleteClothingItem(int id) async {
//   final response = await http.delete(
//     Uri.parse('YOUR_API_ENDPOINT/$id'), // Замените YOUR_API_ENDPOINT на конечную точку вашего API для удаления элемента одежды
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
//   if (response.statusCode != 200) {
//     throw Exception('Failed to delete clothing item');
//   }
// }
// // Функция для получения списка категорий одежды из сети
// Future<List<CategoryClothes>> fetchCategoryClothes() async {
//   final response = await http.get(Uri.parse('YOUR_API_ENDPOINT')); // Замените YOUR_API_ENDPOINT на конечную точку вашего API для получения списка категорий одежды
//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((item) => CategoryClothes.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load category clothes');
//   }
// }
//
// // Функция для создания новой категории одежды
// Future<void> createCategoryClothes(CategoryClothes newCategory) async {
//   final response = await http.post(
//     Uri.parse('YOUR_API_ENDPOINT'), // Замените YOUR_API_ENDPOINT на конечную точку вашего API для создания новой категории одежды
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(newCategory.toJson()),
//   );
//   if (response.statusCode != 201) {
//     throw Exception('Failed to create category clothes');
//   }
// }
//
// // Функция для удаления категории одежды
// Future<void> deleteCategoryClothes(int id) async {
//   final response = await http.delete(
//     Uri.parse('YOUR_API_ENDPOINT/$id'), // Замените YOUR_API_ENDPOINT на конечную точку вашего API для удаления категории одежды
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
//   if (response.statusCode != 200) {
//     throw Exception('Failed to delete category clothes');
//   }
// }
// // Функция для получения списка нарядов из сети
// Future<List<Outfit>> fetchOutfits() async {
//   final response = await http.get(Uri.parse('YOUR_API_ENDPOINT')); // Замените YOUR_API_ENDPOINT на конечную точку вашего API для получения списка нарядов
//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((item) => Outfit.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load outfits');
//   }
// }
//
// // Функция для создания нового наряда
// Future<void> createOutfit(Outfit newOutfit) async {
//   final response = await http.post(
//     Uri.parse('YOUR_API_ENDPOINT'), // Замените YOUR_API_ENDPOINT на конечную точку вашего API для создания нового наряда
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(newOutfit.toJson()),
//   );
//   if (response.statusCode != 201) {
//     throw Exception('Failed to create outfit');
//   }
// }
//
// // Функция для удаления наряда
// Future<void> deleteOutfit(int id) async {
//   final response = await http.delete(
//     Uri.parse('YOUR_API_ENDPOINT/$id'), // Замените YOUR_API_ENDPOINT на конечную точку вашего API для удаления наряда
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
//   if (response.statusCode != 200) {
//     throw Exception('Failed to delete outfit');
//   }
// }