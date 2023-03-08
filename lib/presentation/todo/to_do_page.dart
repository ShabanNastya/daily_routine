import 'package:daily_routine/data/notes_db.dart';
import 'package:daily_routine/presentation/todo/detail_to_to_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../domain/models/todo.dart';
import '../../widgets/to_do_card_widget.dart';
import 'edit_to_do_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late List<Todo> todos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    todos = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-do list page title',
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : todos.isEmpty
                ? const Text('WE have no todos')
                : buildTodos(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTodoPage(),
            ),
          );
          refreshNotes();
        },
        child: const Icon(
          Icons.add_circle_outlined,
        ),
      ),
    );
  }

  Widget buildTodos() {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      itemCount: todos.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailTodoPage(
                  todoId: todo.id!,
                ),
              ),
            );
            refreshNotes();
          },
          child: TodoCardWidget(
            todo: todo,
            index: index,
          ),
        );
      },
    );
  }
}
