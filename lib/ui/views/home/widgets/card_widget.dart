import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:at_events/ui/theme/colors.dart';
import 'package:intl/intl.dart';

class HomeEventsCard extends StatelessWidget {
  final String name;
  final DateTime date;
  final String place;
  final Uint8List image;
  final Function()? onTap;

  const HomeEventsCard({
    super.key,
    required this.name,
    required this.date,
    required this.place,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // FadeInImage(
                //   placeholder: const AssetImage('assets/gifs/loading.gif'),
                //   image: Image.memory(
                //       Uint8List.fromList(image),
                //     ),
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: 200,
                // ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.memory(
                    Uint8List.fromList(image),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('E, d MMM yyyy h:mm a').format(date),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        place,
                        style: TextStyle(color: MyColor.secondary),
                      ),
                      Text(
                        '60 interesados - 50 asistirán',
                        style: TextStyle(color: MyColor.secondary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.star),
                            label: const Text('Me interesa'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColor.secondary,
                              fixedSize: const Size(140, 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {},
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.calendar_today_outlined),
                            label: const Text('Asistiré'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColor.secondary,
                              fixedSize: const Size(140, 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
