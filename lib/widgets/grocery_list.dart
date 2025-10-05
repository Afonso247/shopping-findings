import 'package:flutter/material.dart';
import 'package:findings/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({
    super.key,
    required this.groceryItems,
    required this.onRemoveItem,
    required this.onRestoreItem,
    required this.hasError,
  });

  final String hasError;
  final List<GroceryItem> groceryItems;
  final void Function(int index) onRemoveItem;
  final void Function(int index, GroceryItem item) onRestoreItem;


  void _removeItem(int index, BuildContext context) {
    final removedItem = groceryItems[index];
    final removedIndex = index;

    onRemoveItem(index);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem.name} removido'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            onRestoreItem(removedIndex, removedItem);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (groceryItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            hasError.isNotEmpty
                ? hasError // err handling
                : 'Nenhum item na lista.\nAdicione seus produtos!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(groceryItems[index].id),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 30),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _removeItem(index, context),
        child: ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(groceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
