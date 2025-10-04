import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key, required this.groceryItems});
  
  final List groceryItems;
  
  @override
  Widget build(BuildContext context) {
    if (groceryItems.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum item na lista.\nAdicione seus produtos!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }
    
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