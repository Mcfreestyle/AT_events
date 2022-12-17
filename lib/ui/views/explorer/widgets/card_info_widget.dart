import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final DecorationImage decorationImage;
  final String h1;
  final String h2;
  final String h3;
  final String costo;

  const CardInfo(
      {super.key,
      required this.decorationImage,
      required this.h1,
      required this.h2,
      required this.h3,
      required this.costo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: decorationImage,
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
                  h1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  h2,
                  style: TextStyle(
                    color: MyColor.primary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  h3,
                  style: TextStyle(
                    color: MyColor.lightSecondary,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          (costo == '')
              ? Container()
              : Positioned(
                  top: 10.0,
                  right: 0.0,
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: MyColor.primary,
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        costo,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
