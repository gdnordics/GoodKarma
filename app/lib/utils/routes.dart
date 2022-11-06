import 'package:flutter/widgets.dart';

class Routes {
  static const String splash = "/";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 0}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
    );
  }
}
