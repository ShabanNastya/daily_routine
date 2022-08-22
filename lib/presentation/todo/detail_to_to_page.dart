import 'package:daily_routine/data/notes_db.dart';
import 'package:daily_routine/presentation/todo/edit_to_do_page.dart';
import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class DetailTodoPage extends StatefulWidget {
  const DetailTodoPage({super.key, required this.todoId});

  final int todoId;

  @override
  State<DetailTodoPage> createState() => _DetailTodoPageState();
}

class _DetailTodoPageState extends State<DetailTodoPage> {
  late Todo newTodo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    newTodo = await NotesDatabase.instance.readTodo(widget.todoId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todoId.toString(),
        ),
        actions: [
          editButton(),
          deleteButton(),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  Text('title ${newTodo.title}'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('description ${newTodo.description}')
                ],
              ),
            ),
    );
  }

  Widget editButton() {
    return IconButton(
        onPressed: () async {
          if (isLoading) return;
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTodoPage(
                todo: newTodo,
              ),
            ),
          );
          refreshNote();
        },
        icon: const Icon(Icons.edit));
  }

  Widget deleteButton() {
    return IconButton(
        onPressed: () async {
          await NotesDatabase.instance.deleteTodo(widget.todoId);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.delete));
  }
}
