import 'package:snackmate/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snackmate/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snackmate/models/nutrition.dart';
import 'package:rxdart/rxdart.dart';

class RecipeService {
  FirebaseStorage _firebaseStorage;
  FirebaseAuth _auth;
  BehaviorSubject<List<Recipe>>
  _recipeObservable; // Asynchronously provide data

  RecipeService() {
    this._firebaseStorage = FirebaseStorage.instance;
    this._auth = FirebaseAuth.instance;
    _auth
        .signInAnonymously(); // Need to be authenticated to access project storage
    _recipeObservable = BehaviorSubject();
  }

  Observable<List<Recipe>> getRecipes() {
    /*
      Get recipe stream, map each document into a Recipe and return that as a list
     */
    Firestore.instance.collection('recipes').snapshots().listen((snapshot) {
      List<Future<Recipe>> futureList =
      snapshot.documents.map((document) async {
        return await parseRecipe(document);
      }).toList();
      /*
         Future.wait takes a list(iterable) of futures(promises), it then waits
         until all of them have completed before unwrapping each one so you are
         left with just the synchronous list
       */
      Future.wait(futureList).then((syncList) {
        _recipeObservable.add(syncList); // Now we add the list to our observable, which we can await in the feed page
      });
    });
    return _recipeObservable;
  }

  Future<Recipe> parseRecipe(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data;
    String id = data['recipeId'];
    StorageReference imageRef = await _firebaseStorage.getReferenceFromUrl(
        'gs://snackmate-e27e4.appspot.com/recipes/$id.jpg');
    Recipe recipe;
    return imageRef.getData(100000000).then((image) {
      recipe = Recipe(
        id: id,
        date: (data['date'] as Timestamp).toDate(),
        author: User(image: 'images/talin.jpg', name: 'Luke'),
        title: data['name'],
        nutrition: Nutrition(
            calories: data['nutrition']['calories'],
            carbs: data['nutrition']['carbs'],
            fat: data['nutrition']['fat'],
            protein: data['nutrition']['protein']),
        description: data['description'],
        image:
        image, //'https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg'
      );
      return recipe;
    });
  }

  void onDispose() {
    _recipeObservable.close();
  }
}
