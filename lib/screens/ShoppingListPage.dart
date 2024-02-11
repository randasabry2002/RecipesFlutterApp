import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../controllers/ShoppingListController.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final ShoppingListController shoppingListController =
  Get.put(ShoppingListController());
  String? userName;

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) async {
      userName = value.getString("userName").toString();
      await shoppingListController.getUserShoppingList(userName!);
      setState(() {});
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Shopping List',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<ShoppingListController>(
            builder: (val) {
              if (val.UserShoppingList.isEmpty) {
                // Display a message when the shopping list is empty
                return Center(
                  child: Text(
                    'Your shopping list is empty.',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                // Display the list of items in the shopping list
                return ListView.builder(
                  itemCount: val.UserShoppingList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                val.UserShoppingList[index].IngredientName!,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                shoppingListController
                                    .deleteIngredientToShoppingList(
                                    val.UserShoppingList[index].DocId!);
                              },
                              icon: Icon(Icons.remove,color: Colors.red,),
                            ),
                            Text(
                              val.UserShoppingList[index].Amount!,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
