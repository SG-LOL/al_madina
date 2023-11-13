import 'package:flutter/material.dart';

Future<void> showErrorDialo(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("an error has occurred"),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      });
}
