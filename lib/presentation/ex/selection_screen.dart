import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pick a option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'YESSSS');
                },
                child: const Text('Yes')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'NNNNNo');
                },
                child: const Text('Nope'))
          ],
        ),
      ),
    );
  }
}
