import 'package:flutter/material.dart';
import 'package:at_events/ui/theme/colors.dart';

InputDecoration myInputDecoration({String? hintText, Widget? suffixIcon}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: MyColor.terciary,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: MyColor.terciary,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    hintText: hintText,
    filled: true,
    fillColor: MyColor.terciary,
    contentPadding: const EdgeInsets.all(12),
    suffixIcon: suffixIcon,
  );
}
