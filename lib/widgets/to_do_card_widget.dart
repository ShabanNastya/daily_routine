import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/models/todo.dart';

class TodoCardWidget extends StatelessWidget {
  final Todo todo;
  final int index;

  TodoCardWidget({required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      child: Container(
        constraints: const BoxConstraints(minHeight: 150),
        padding: const EdgeInsets.all(8),
        child: Text(todo.title),
      ),
    );
  }
}
