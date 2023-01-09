import 'package:flutter/material.dart';

import 'package:at_events/ui/styles/inputdecoration_style.dart';
import 'package:at_events/ui/theme/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;

  const TextFieldWidget({
    super.key,
    required this.keyboardType,
    this.suffixIcon,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: MyColor.primary,
      obscureText: obscureText,
      decoration: myInputDecoration(hintText: hintText, suffixIcon: suffixIcon),
      minLines: (keyboardType == TextInputType.multiline) ? 3 : 1,
      maxLines: (keyboardType == TextInputType.multiline) ? 10 : 1,
    );
  }
}
