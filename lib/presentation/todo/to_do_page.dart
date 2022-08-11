import 'package:daily_routine/presentation/todo/detail_to_to_page.dart';
import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key? key}) : super(key: key);

  final List<Todo> todos = List.generate(15, (i) => Todo(
    'Todo $i number',
    'A description of $i notes to be taken'
  ));



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do list page title'),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailTodoPage(todo: todos[index])));
              },
            );
          }),
    );
  }
}
