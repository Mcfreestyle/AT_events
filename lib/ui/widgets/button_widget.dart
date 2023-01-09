import 'package:flutter/material.dart';

import 'package:at_events/ui/theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final String type;
  final Function()? onPressed;
  final double fontSize;

  const ButtonWidget({
    super.key,
    required this.title,
    this.type = 'primary',
    required this.onPressed,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle(),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, color: _textColor()),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    late ButtonStyle style;

    switch (type) {
      case 'primary':
        style = ElevatedButton.styleFrom(
          backgroundColor: MyColor.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
        break;
      case 'secondary':
        style = ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: MyColor.primary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
        break;
      case 'terciary':
        style = ElevatedButton.styleFrom(
          backgroundColor: MyColor.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
        break;
    }

    return style;
  }

  Color _textColor() {
    late Color color;
    switch (type) {
      case 'primary':
        color = Colors.white;
        break;
      case 'secondary':
        color = MyColor.primary;
        break;
      case 'terciary':
        color = MyColor.secondary;
        break;
    }
    return color;
  }
}
