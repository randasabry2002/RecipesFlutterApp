import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ShoppingListModel.dart';

class ShoppingListController extends GetxController {
  var _firestore = FirebaseFirestore.instance;
  var ShoppingList = <ShoppingListModel>[].obs;
  var UserShoppingList = <ShoppingListModel>[].obs;
  var ItemInShoppingList = ShoppingListModel().obs;
  var isInShoppingList = false.obs;

  var shoppingCounter = 0.obs; // New variable to track shopping counter

  Future<void> getShoppingList() async {
    var response = _firestore.collection("ShoppingList");
    QuerySnapshot querySnapshot = await response.get();

    ShoppingList.value = querySnapshot.docs.map((doc) {
      return ShoppingListModel(
        DocId: doc.id,
        UserName: doc.get('UserName'),
        IngredientName: doc.get('IngredientName'),
        DoneOrNot: doc.get('DoneOrNot'),
        Amount: doc.get('Amount'),
      );
    }).toList();
  }

  getUserShoppingList(String userName) {
    UserShoppingList.clear();
    getShoppingList();

    for (var i = 0; i < ShoppingList.length; i++) {
      if (ShoppingList[i].UserName == userName) {
        UserShoppingList.add(ShoppingList[i]);
      }
    }
    update();
  }

  inShoppingListOrNot(String userName, String ingredientName) async {
    isInShoppingList.value = false;
    await getUserShoppingList(userName);

    for (var i = 0; i < UserShoppingList.length; i++) {
      if (UserShoppingList[i].IngredientName == ingredientName) {
        isInShoppingList.value = true;
        ItemInShoppingList.value = UserShoppingList[i];
      }
    }
    update();
  }

  deleteIngredientToShoppingList(String docId) async {
    try {
      await _firestore.collection("ShoppingList").doc(docId).delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
    update();
  }

  addIngredientToShoppingList(String userName, String ingredientName) async {
    try {
      await _firestore.collection("ShoppingList").add({
        "UserName": userName,
        "IngredientName": ingredientName,
        "Amount": "",
        "DoneOrNot": false,
      });
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
    update();
  }


}
