import 'package:flutter/material.dart';

class CreateNewItem extends StatefulWidget {
  const CreateNewItem({super.key});

  @override
  State<CreateNewItem> createState() => _CreateNewItemState();
}

class _CreateNewItemState extends State<CreateNewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text('Formulário'),
    );
  }
}
