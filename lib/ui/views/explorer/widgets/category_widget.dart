import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class CatEvent extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function() onTap;

  const CatEvent({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            IconButton(
              padding: const EdgeInsets.all(15),
              iconSize: 30,
              onPressed: () {},
              icon: icon,
              // style: ButtonStyle(
              //   shape: MaterialStateProperty.all(const CircleBorder()),
              //   backgroundColor: MaterialStateProperty.all(MyColor.lightPrimary),
              //   foregroundColor: MaterialStateProperty.all(MyColor.primary),
              //   shadowColor: MaterialStateProperty.all(MyColor.secondary),
              //   elevation: MaterialStateProperty.all(0),
              // ),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: MyColor.primary,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
