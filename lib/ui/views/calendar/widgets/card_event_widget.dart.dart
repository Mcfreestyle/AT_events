import 'dart:typed_data';

import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardEventCalendar extends StatelessWidget {
  final Uint8List? uint8Image;
  final String? titleEvent;
  final DateTime? hoursEvent;
  final Function() onTap;

  const CardEventCalendar({
    Key? key,
    this.titleEvent,
    this.hoursEvent,
    this.uint8Image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 330,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.black,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // FadeInImage(
                //   placeholder: AssetImage('assets/gifs/loading.gif'),
                //   image: NetworkImage('$imageEvent'),
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: 160,
                // ),
                SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Image.memory(
                    Uint8List.fromList(uint8Image!),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$titleEvent',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      Text('Hora: ${DateFormat('h:mm a').format(hoursEvent!)}')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        /*Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Colors.black,
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
    
                    // color: Colors.white,
                  ),
                  /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                            20) //                 <--- border radius here
                        ),
                  ),*/
                  height: 160.0,
                  child: Ink.image(
                    image: NetworkImage('$imageEvent'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('$titleEvent',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17))
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [Text('Hora: $hoursEvent')],
                          ),
                        )
                      ],
                    )),
              ],
            )),
            */
      ),
    );
  }
}
