import 'package:flutter/material.dart';
import 'package:tiktokclone/utils/constants.dart';

class Utils {
  final String message;

  const Utils({required this.message});

  static snackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: kButtomColor,
      ),
    );
  }
}
