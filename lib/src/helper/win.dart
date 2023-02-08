import 'package:flutter/material.dart';

class Alerts {
  static loading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Container(
                width: 60, height: 60, child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
