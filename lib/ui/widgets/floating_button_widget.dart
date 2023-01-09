import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function() onPressed;

  const FloatingButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      onPressed: onPressed,
      backgroundColor: Colors.white,
      foregroundColor: MyColor.secondary,
      mini: true,
      child: icon,
    );
  }
}
