import 'package:daily_routine/data/model/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../data/repository/socket_repository.dart';
import '../../widgets/message_item.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
  }) : super(key: key);


  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController? _messageController;
  IO.Socket? socket;

  MessageController messageController = MessageController();

  @override
  void initState() {
    _messageController = TextEditingController();
    socket = IO.io(
        'http://localhost:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket!.connect();
    setUpListen();
    super.initState();
  }

  void sendMessage(String text) {
    var messageJson = {"message": text, "sentByMe": socket!.id,};
    socket!.emit('message', messageJson);
    messageController.messageChat.add(Message.fromJson(messageJson,),);
  }

  void setUpListen() {
    socket!.on(
      'message-receive',
      (data) => {
        messageController.messageChat.add(
          Message.fromJson(data),
        ),
      },
    );

    socket!.on(
      'connected-user',
          (data) => {
        messageController.connectedUser.value = data
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Page'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(
          ()=> Text(
                'Connected User ${messageController.connectedUser}',
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: messageController.messageChat.length,
                itemBuilder: (context, index) {
                  var currentItem = messageController.messageChat[index];
                  return MessageItem(
                    sentByMe: currentItem.sentByMe == socket!.id,
                    textMessage: currentItem.message,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type smth...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(_messageController!.text);
                    _messageController!.text = '';
                  },
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
