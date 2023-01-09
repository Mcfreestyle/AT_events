import 'package:flutter/material.dart';

class SnackBarMsg {
  static GlobalKey<ScaffoldMessengerState> msgKey =
      GlobalKey<ScaffoldMessengerState>();

  static appearSnackBar(String msg, {String type = 'primary'}) {
    late Color color;
    switch (type) {
      case 'primary':
        color = Colors.green;
        break;
      case 'warning':
        color = Colors.orange;
        break;
      case 'alert':
        color = Colors.red;
        break;
    }

    final snackbar = SnackBar(
      backgroundColor: color,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
    );
    msgKey.currentState?.showSnackBar(snackbar);
  }
}
