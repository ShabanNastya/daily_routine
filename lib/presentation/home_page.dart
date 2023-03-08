import 'package:daily_routine/presentation/chat/chat_page.dart';
import 'package:daily_routine/presentation/todo/to_do_page.dart';
import 'package:flutter/material.dart';
import 'charts/circular_chart.dart';
import 'message/message_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _widgetOptions = const [
    MessagePage(),
    ChatPage(),
    TodoPage(),
    CircularChart(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Todo rxDart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'To-do sqlite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: 'Chart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
