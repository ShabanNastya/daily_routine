import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation/routes.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text('Chat screen'),
        ),
        OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.home);
            },
            child: const Text('Bar Chart'))
      ],
    );
  }
}
