import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatelessWidget {
  final DecorationImage img;
  final String h1;
  final String h2;
  final String h3;
  final String h4;

  const CardEvent(
      {super.key,
      required this.img,
      required this.h1,
      required this.h2,
      required this.h3,
      required this.h4});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: img,
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
                          h1,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          h2,
                          style: TextStyle(
                            color: MyColor.secondary,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          h3,
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
    );
  }
}
