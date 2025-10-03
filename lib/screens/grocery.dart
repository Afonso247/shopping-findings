import 'package:flutter/material.dart';

import 'package:findings/widgets/grocery_list.dart';

class Grocery extends StatelessWidget {
  const Grocery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery List')),
      body: GroceryList(),
    );
  }
}
