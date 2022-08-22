import 'package:daily_routine/data/notes_db.dart';
import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';
import '../../widgets/to_do_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo? todo;

  EditTodoPage({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _editTodoKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.todo?.title ?? '';
    description = widget.todo?.description ?? '';
  }

  void addOrUpdateTodo() async {
    final isValid = _editTodoKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.todo != null;

      if (isUpdating) {
        await updateTodo();
      } else {
        await addNewTodo();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateTodo() async {
    final updateTodo =
        widget.todo!.copy(title: title, description: description);
    await NotesDatabase.instance.updateTodo(updateTodo);
  }

  Future addNewTodo() async {
    final newTodo = Todo(title: title, description: description);
    await NotesDatabase.instance.createNote(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _editTodoKey,
        child: TodoFormWidget(
          title: title,
          description: description,
          onChangedTitle: (title) => setState(() {
            this.title = title;
          }),
          onChangedDescription: (description) => setState(() {
            this.description = description;
          }),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: addOrUpdateTodo,
        child: const Text('Save'),
      ),
    );
  }
}
