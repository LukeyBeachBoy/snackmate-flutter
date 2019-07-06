import 'dart:typed_data';
import 'nutrition.dart';
import 'user.dart';

class Recipe {
  String title;
  User author;
  DateTime date;
  String description;
  Nutrition nutrition;
  String id;
  Uint8List image;

  Recipe(
      {this.id,
      this.image,
      this.description,
      this.author,
      this.date,
      this.nutrition,
      this.title});
}
