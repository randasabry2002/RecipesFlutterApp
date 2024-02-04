import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../controllers/ShoppingListController.dart';

class ShoppingListPage extends StatefulWidget{
  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final ShoppingListController shoppingListController = Get.put(ShoppingListController());
  String? userName;

  // check(var val,var index) async {
  //   await shoppingListController.inShoppingListOrNot(userName!,val.UserShoppingList[index].IngredientName!);
  //   setState(() {
  //
  //   });
  // }


  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then((value) async {
      userName = value.getString("userName").toString();
      await shoppingListController.getUserShoppingList(userName!);
      setState(() {
      });
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ShoppingList',
            style: TextStyle(fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          elevation: 0.0,
        ),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child:  GetBuilder<ShoppingListController>(
                    builder: (val) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: val.UserShoppingList.length,
                        itemBuilder: (context, index) {
                          // check(val,index);
                          // print(shoppingListController.isInShoppingList.value);
                          // Build a ListTile for each ingredient with a specific font size
                          return ListTile(
                            // if the Ingredients not null that come from firebase show it
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          val.UserShoppingList[index].IngredientName!,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Spacer(),
                                        // !shoppingListController.isInShoppingList.value?

                                          IconButton(onPressed: (){
                                          shoppingListController.deleteIngredientToShoppingList(val.UserShoppingList[index].DocId!);

                                          }, icon: Icon(Icons.minimize)),
                                        Icon(Icons.add_shopping_cart_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                                // Check if Amount is not null before displaying it
                                Text(
                                  val.UserShoppingList[index].Amount!,
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}