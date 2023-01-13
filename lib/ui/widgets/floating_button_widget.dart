import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final Widget icon;
  final String type;
  final Function() onPressed;

  const FloatingButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    this.type = 'primary',
  });

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Color foregroundColor;

    switch (type) {
      case 'primary':
        backgroundColor = MyColor.primary;
        foregroundColor = Colors.white;
        break;
      case 'secondary':
        backgroundColor = Colors.white;
        foregroundColor = MyColor.secondary;
    }

    return FloatingActionButton(
      heroTag: UniqueKey(),
      elevation: 1,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      mini: true,
      child: icon,
    );
  }
}
