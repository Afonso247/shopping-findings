import 'package:flutter/material.dart';

import 'package:findings/data/dummy_items.dart';
import 'package:findings/widgets/grocery_list.dart';
import 'package:findings/models/grocery_item.dart';
import 'package:findings/screens/new_item.dart';

class Grocery extends StatefulWidget {
  const Grocery({super.key});

  @override
  State<Grocery> createState() => _GroceryState();
}

class _GroceryState extends State<Grocery> {
  @override
  Widget build(BuildContext context) {
    final List<GroceryItem> myGroceryItems = groceryItems;

    void groceryItemsAdd() async {
      final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (context) => const NewItem()),
      );

      if (newItem != null) {
        setState(() {
          myGroceryItems.add(newItem);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        actions: [
          IconButton(
            onPressed: groceryItemsAdd,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GroceryList(groceryItems: myGroceryItems),
    );
  }
}
