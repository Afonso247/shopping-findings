import 'package:flutter/material.dart';

import 'package:findings/widgets/grocery_list.dart';
import 'package:findings/screens/new_item.dart';

class Grocery extends StatelessWidget {
  const Grocery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const NewItem()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GroceryList(),
    );
  }
}
