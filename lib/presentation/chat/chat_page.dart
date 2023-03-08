import 'package:flutter/material.dart';

import '../message/message_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController? _nameController;
  String? _username;

  List<String> messageList = [];
  final _formChatKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Group'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await _showCreateChat(context);
          },
          child: const Text(
            'Create chat',
          ),
        ),
      ),
    );
  }

  Future _showCreateChat(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please enter your name'),
            content: Form(
              key: _formChatKey,
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'Please enter some name';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
              TextButton(
                ///TO:DO Navigation to chat
                onPressed: () {
                  if (_formChatKey.currentState!.validate()) {
                    Navigator.pop(context);
                    _username = _nameController!.text;
                    _nameController!.clear();
                  }
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _nameController!.dispose();
    super.dispose();
  }
}
