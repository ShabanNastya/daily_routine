import 'package:daily_routine/presentation/ex/selection_screen.dart';
import 'package:flutter/material.dart';

class SelectionButton extends StatefulWidget {
  const SelectionButton({Key? key}) : super(key: key);

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
        child: const Text('Pick an option button'));
  }
}

Future<void> _navigateAndDisplaySelection(BuildContext context) async {
  final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()));

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$result')));
}
