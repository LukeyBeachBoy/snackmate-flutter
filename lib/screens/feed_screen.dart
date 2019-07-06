import 'package:flutter/material.dart';
import 'package:snackmate/constants.dart';
import 'package:snackmate/components/recipe_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snackmate/components/snackmate_app_bar.dart';
import 'package:snackmate/components/snackmate_icons_icons.dart';
import 'package:snackmate/services/recipe_service.dart';
import 'package:snackmate/models/recipe.dart';
import 'package:rxdart/rxdart.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  RecipeService recipeService = RecipeService();
  Observable<List<Recipe>> recipeList;

  @override
  void initState() {
    recipeList = recipeService.getRecipes();
    super.initState();
  }

  @override
  void dispose() {
    recipeService.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new SnackmateAppBar(),
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          child: TabBar(
              labelColor: kColPrimary,
              indicator:
              ShapeDecoration(shape: Border(bottom: BorderSide.none)),
              unselectedLabelColor: kColInactive,
              tabs: [
                Tab(
                  icon: Icon(
                    SnackmateIcons.home_outline,
                    color: kColPrimary,
                  ),
                ),
                Tab(
                  icon: Icon(SnackmateIcons.search_outline),
                ),
                Tab(
                  icon: Icon(SnackmateIcons.edit),
                ),
                Tab(
                  icon: Icon(SnackmateIcons.user_outline),
                ),
              ]),
        ),
        body: StreamBuilder(
            stream: recipeList,
            builder: (context, snap) {
              if (!snap.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              List<RecipeCard> finalList = (snap.data as List<Recipe>).map((recipe) {
                return RecipeCard(recipe);
              }).toList();
              return ListView(children: finalList, );
            }),
      ),
    );
  }
}
