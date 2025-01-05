import 'package:flutter/material.dart';

void mySnackBar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Playlist already exists'),
    ),
  );
}
