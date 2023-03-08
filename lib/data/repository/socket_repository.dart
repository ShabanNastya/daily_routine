import 'package:daily_routine/data/model/message.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var messageChat = <Message>[].obs;

  var connectedUser = 0.obs;
}
