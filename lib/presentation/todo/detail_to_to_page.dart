import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class DetailTodoPage extends StatelessWidget {
  const DetailTodoPage({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
            child: Text(
          todo.description,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        )),
      ),
    );
  }
}
