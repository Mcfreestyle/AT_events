import 'dart:typed_data';

import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final DateTime date;
  final String place;
  final double price;
  final Uint8List uint8Image;
  final Function() onTap;

  const CardInfo({
    super.key,
    required this.title,
    required this.date,
    required this.place,
    required this.price,
    required this.uint8Image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              width: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    Uint8List.fromList(uint8Image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(.25),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    DateFormat('E, d MMM yyyy h:mm a').format(date),
                    style: TextStyle(
                      color: MyColor.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    place,
                    style: TextStyle(
                      color: MyColor.lightSecondary,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            (price == 0)
                ? Container()
                : Positioned(
                    top: 10.0,
                    right: 0.0,
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: MyColor.primary,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          price.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
