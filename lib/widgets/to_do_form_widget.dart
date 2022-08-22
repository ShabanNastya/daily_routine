import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const TodoFormWidget(
      {super.key,
      this.title = '',
      this.description = '',
      required this.onChangedTitle,
      required this.onChangedDescription});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(
                height: 8,
              ),
              buildDescription(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
