import 'package:flutter/material.dart';
import 'package:snackmate/models/recipe.dart';
import 'package:snackmate/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NutritionPill extends StatelessWidget {
  NutritionPill({this.recipe, this.displayValue});

  final String displayValue;
  final Recipe recipe;

  int displayNutrition() {
    switch (displayValue) {
      case 'Calories':
        return recipe.nutrition.calories;
        break;
      case 'Carbs':
        return recipe.nutrition.carbs;
        break;
      case 'Protein':
        return recipe.nutrition.protein;
        break;
      case 'Fat':
        return recipe.nutrition.fat;
        break;
      default:
        return recipe.nutrition.calories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFFF6CF74),
              borderRadius: BorderRadius.circular(60),
            ),
            child: AutoSizeText(
              displayNutrition().toString(),
              style: kRecipeCardTitle.copyWith(fontSize: 14),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          AutoSizeText(
            displayValue,
            style: kRecipeCardTitle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
