import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

String exception = 'Something went wrong. Check your connection or restart the app.';

Future<void> showException(
  BuildContext context,
) async {
  return Toast.show(exception, context, gravity: Toast.BOTTOM);
}
