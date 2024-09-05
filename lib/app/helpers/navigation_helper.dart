import 'package:flutter/material.dart';

class NavigationHelper {
  NavigationHelper._privateConstructor();
  static final NavigationHelper _instance =
      NavigationHelper._privateConstructor();
  static NavigationHelper get instance => _instance;

  back({required BuildContext context, Object? result}) {
    Navigator.of(context).pop(result);
  }


to({required BuildContext context, required Widget page}) {
  Navigator.of(context).push(FadeRouteBuilder(page: page));
}

toWithResult({required BuildContext context, required Widget page}) async {
  final result = await Navigator.of(context).push(FadeRouteBuilder(page: page));

  return result;
}

}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
