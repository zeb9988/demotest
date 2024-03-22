import 'package:flutter/material.dart';

import 'dart:io';

void showCustomSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
