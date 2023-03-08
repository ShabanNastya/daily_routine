import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final bool sentByMe;
  final String textMessage;

  const MessageItem({
    Key? key,
    required this.sentByMe,
    required this.textMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        color: sentByMe ? Colors.deepPurpleAccent : Colors.cyanAccent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              textMessage,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              '1:50pm',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
