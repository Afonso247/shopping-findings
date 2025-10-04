import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key, required this.groceryItems});

  final List groceryItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(groceryItems[index].name),
        leading: Container(
          width: 24,
          height: 24,
          color: groceryItems[index].category.color,
        ),
        trailing: Text(groceryItems[index].quantity.toString()),
      ),
    );
  }
}
