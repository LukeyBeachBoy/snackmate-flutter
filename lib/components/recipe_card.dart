import 'package:flutter/material.dart';
import 'package:snackmate/constants.dart';
import 'package:snackmate/models/recipe.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:snackmate/components/snackmate_icons_icons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'nutrition_pill.dart';

class RecipeCard extends StatelessWidget {
  final Recipe _recipe;

  RecipeCard(this._recipe);

  @override
  Widget build(BuildContext context) {
    FadeInImage _image = FadeInImage.assetNetwork(
      placeholder: kTransparentImage.toString(),
      image: _recipe.image,
      fit: BoxFit.cover,
      height: 220,
    );

    return Container(
      decoration: BoxDecoration(
        // Give the recipe card curved corners
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(20),
              offset: Offset(0, 8),
              blurRadius: 15),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /*
              Recipe Image
             */

          ClipRRect(
            // Rounded image
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: _image),

          /*
              Recipe Card body
             */

          Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            color: Colors.white,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*
                    Title Container
                   */

                Container(
                    child: AutoSizeText(
                      _recipe.title,
                      overflow: TextOverflow.ellipsis ,
                      style: kRecipeCardTitle,
                    ),
                  padding: EdgeInsets.symmetric(
    horizontal: 25, vertical: 12),
                  width: double.infinity,
                  ),


                /*
                    Author Section
                   */
                Container(
                  color: kColOffWhite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              width: MediaQuery.of(context).size.width / 7.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Image(
                                  image: AssetImage(_recipe.author.image),
                                ),
                              ),
                            ),
                            AutoSizeText(
                              _recipe.author.name,
                              style: kRecipeCardAuthorDate,
                            )
                          ],
                        ),
                        Expanded(
                          child: AutoSizeText(
                            Moment.now().from(_recipe.date),
                            style: kRecipeCardAuthorDate.copyWith(fontSize: 11),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /*
                    Main body section
                   */

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    children: <Widget>[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int dynamicFlex = 8;
                          if (constraints.maxWidth >= 300) {
                            // Nexus 6P
                            dynamicFlex = 3;
                          } else if (constraints.maxWidth >= 200) {
                            // iPhone 7
                            dynamicFlex = 5;
                          } else if (constraints.maxWidth >= 150) {
                            // iPhone 5s
                            dynamicFlex = 6;
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: <Widget>[
                                          AutoSizeText(
                                            'Description',
                                            textAlign: TextAlign.left,
                                            style: kRecipeCardHeader,
                                          ),
                                        ],
                                      ),
                                    ),
                                    AutoSizeText(
                                      _recipe.description,
                                      style: kRecipeCardDescription,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                flex: dynamicFlex,
                                // This needs to change with screen size
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: AutoSizeText(
                                        'Nutrition',
                                        style: kRecipeCardHeader,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Column(
                                        children: <Widget>[
                                          NutritionPill(
                                            recipe: _recipe,
                                            displayValue: 'Calories',
                                          ),
                                          NutritionPill(
                                            recipe: _recipe,
                                            displayValue: 'Protein',
                                          ),
                                          NutritionPill(
                                            recipe: _recipe,
                                            displayValue: 'Carbs',
                                          ),
                                          NutritionPill(
                                            recipe: _recipe,
                                            displayValue: 'Fat',
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          textBaseline: TextBaseline.ideographic,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                SnackmateIcons.heart_filled,
                                color: kColPrimary,
                              ),
                            ),
                            AutoSizeText(
                              '203',
                              style: kRecipeCardHeader.copyWith(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 13),
                              child: Icon(
                                SnackmateIcons.chat_alt,
                                color: kColPrimary,
                              ),
                            ),
                            AutoSizeText(
                              '10',
                              style: kRecipeCardHeader.copyWith(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
