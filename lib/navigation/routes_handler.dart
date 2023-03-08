import 'package:daily_routine/navigation/routes.dart';
import 'package:daily_routine/presentation/charts/circular_chart.dart';
import 'package:daily_routine/presentation/chat/chat_page.dart';
import 'package:flutter/material.dart';

import '../presentation/home_page.dart';
import '../presentation/message/message_page.dart';
import '../presentation/todo/to_do_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const HomePage(),
      );
    case Routes.circularChart:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const CircularChart(),
      );
    case Routes.todoPage:
      return _getPageRoute(
        routeName: settings.name!,
        screen: TodoPage(),
      );
    case Routes.messagePage:
      return _getPageRoute(
        routeName: settings.name!,
        screen: MessagePage(),
      );
    case Routes.chatPage:
      return _getPageRoute(
        routeName: settings.name!,
        screen: ChatPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'Error. No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget screen,
}) {
  return _FadeRoute(
    routeName: routeName,
    child: screen,
  );
}

class _FadeRoute extends PageRouteBuilder {
  final String routeName;
  final Widget child;

  _FadeRoute({
    required this.routeName,
    required this.child,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
