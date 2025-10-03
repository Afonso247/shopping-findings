import 'package:flutter/material.dart';

import 'package:findings/widgets/create_new_item.dart';

class NewItem extends StatelessWidget {
  const NewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Novo Item')),
      body: CreateNewItem(),
    );
  }
}