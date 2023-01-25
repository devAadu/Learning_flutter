
import 'package:flutter/material.dart';
import 'package:learning_flutter/main.dart';

/*class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => MyHomePage(title: args)
          );
        }
        return _errorRoute();

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();

    }

}

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }




}*/


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => const MyHomePage(title: "Hello")
          );
        }
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

