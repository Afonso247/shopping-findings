import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:findings/data/categories.dart';
import 'package:findings/widgets/grocery_list.dart';
import 'package:findings/models/grocery_item.dart';
import 'package:findings/screens/new_item.dart';

class Grocery extends StatefulWidget {
  const Grocery({super.key});

  @override
  State<Grocery> createState() => _GroceryState();
}

class _GroceryState extends State<Grocery> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-testing-f9db5-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(url);

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries.firstWhere(
        (catItem) => catItem.value.title == item.value['category'],
      );
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category.value,
        ),
      );
    }

    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

  void _removeItem(int index) async {
    final item = _groceryItems[index];

    setState(() {
      _groceryItems.removeAt(index);
    });

    final url = Uri.https(
      'flutter-testing-f9db5-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // Se houver erro, reinsere o item
      setState(() {
        _groceryItems.insert(index, item);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao remover item. Tente novamente.'),
          ),
        );
      }
    }
  }

  void _restoreItem(int index, GroceryItem item) async {
    setState(() {
      _groceryItems.insert(index, item);
    });

    // Recria o item no Firebase
    final url = Uri.https(
      'flutter-testing-f9db5-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': item.name,
        'quantity': item.quantity,
        'category': item.category.title,
      }),
    );

    if (response.statusCode >= 400) {
      // Se houver erro ao restaurar no Firebase, remove da UI novamente
      setState(() {
        _groceryItems.removeAt(index);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao restaurar item. Tente novamente.'),
          ),
        );
      }
    }
  }

  void groceryItemsAdd() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        actions: [
          IconButton(onPressed: groceryItemsAdd, icon: const Icon(Icons.add)),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Carregando suas compras...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : GroceryList(
              groceryItems: _groceryItems,
              onRemoveItem: _removeItem,
              onRestoreItem: _restoreItem,
            ),
    );
  }
}
