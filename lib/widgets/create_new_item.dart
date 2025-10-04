import 'package:flutter/material.dart';

import 'package:findings/data/categories.dart';

class CreateNewItem extends StatefulWidget {
  const CreateNewItem({super.key});

  @override
  State<CreateNewItem> createState() => _CreateNewItemState();
}

class _CreateNewItemState extends State<CreateNewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories.entries.first.value;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint('$_enteredName, $_enteredQuantity, $_selectedCategory');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Nome')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O nome não pode ser vazio';
                } else if (value.trim().length < 3) {
                  return 'O nome deve ter pelo menos 3 caracteres';
                } else if (value.trim().length > 50) {
                  return 'Houve um erro. Tente novamente';
                }
                return null;
              },
              onSaved: (value) {
                _enteredName = value!;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Quantidade'),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _enteredQuantity.toString(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A quantidade não pode ser vazia';
                      } else if (int.tryParse(value) == null) {
                        return 'Houve um erro. Tente novamente';
                      } else if (int.tryParse(value)! <= 0) {
                        return 'A quantidade deve ser maior que zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredQuantity = int.parse(value!);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: _selectedCategory,
                    decoration: const InputDecoration(
                      label: Text('Categoria'),
                    ),
                    items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 6),
                              Text(category.value.title),
                            ],
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
