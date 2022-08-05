import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text('Status screen'),
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Input text...'),
          ),
        )
      ],
    );
  }
}
