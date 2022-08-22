import 'package:daily_routine/navigation/routes_handler.dart';
import 'package:daily_routine/presentation/home_page.dart';
import 'package:daily_routine/presentation/settings/settings_page.dart';
import 'package:daily_routine/presentation/status/status_page.dart';
import 'package:daily_routine/presentation/todo/to_do_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final _widgetOptions = [
    HomePage(),
    ///ChatPage(),
    TodoPage(),
    StatusPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      ///How to preserve the state of pages
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_sharp), label: 'Bar Chart'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Status'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
