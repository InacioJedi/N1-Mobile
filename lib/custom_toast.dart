import 'package:flutter/material.dart';

class CustomToast {
  static void show(
      BuildContext context,
      String message, {
        Color backgroundColor = Colors.greenAccent,
        Color textColor = Colors.white,
      }) {
    final overlay = Overlay.of(context)!;
    final toast = _buildToastWidget(message, backgroundColor, textColor);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => toast,
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  static Widget _buildToastWidget(
      String message,
      Color backgroundColor,
      Color textColor,
      ) {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
