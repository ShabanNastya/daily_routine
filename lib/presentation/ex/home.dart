import 'package:daily_routine/presentation/ex/selection_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('return data'),
      ),
      body: const Center(child: SelectionButton()),
    );
  }
}
