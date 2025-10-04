import 'package:flutter/material.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key, required this.groceryItems});

  final List groceryItems;

  @override
  State<GroceryList> createState() => _GroceryListState();
}

// TODO: rework no widget.groceryItems no uso do backend
class _GroceryListState extends State<GroceryList> {
  void _removeItem(int index) {
    final removedItem = widget.groceryItems[index];

    setState(() {
      widget.groceryItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem.name} removido'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              widget.groceryItems.insert(index, removedItem);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groceryItems.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum item na lista.\nAdicione seus produtos!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(widget.groceryItems[index]),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 30),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _removeItem(index),
        child: ListTile(
          title: Text(widget.groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: widget.groceryItems[index].category.color,
          ),
          trailing: Text(widget.groceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
