import 'dart:typed_data';

import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardEvent extends StatelessWidget {
  final String title;
  final DateTime date;
  final String place;
  final String h4;
  final Uint8List uint8Image;
  final Function() onTap;

  const CardEvent({
    super.key,
    required this.title,
    required this.date,
    required this.place,
    required this.h4,
    required this.uint8Image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: MyColor.lightSecondary,
                  blurRadius: 5,
                  offset: const Offset(1, 1)),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    /* img */
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          Uint8List.fromList(uint8Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    /* datos */
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            DateFormat('E, d MMM yyyy h:mm a').format(date),
                            style: TextStyle(
                              color: MyColor.secondary,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            place,
                            style: TextStyle(
                              color: MyColor.secondary,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            h4,
                            style: TextStyle(
                              color: MyColor.secondary,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              /* Positioned(
                right: 10,
                bottom: 20,
                child: Text(
                  h4,
                  style: TextStyle(
                    color: Colores.black1,
                    fontSize: 12.0,
                  ),
                ),
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
