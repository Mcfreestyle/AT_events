import 'dart:typed_data';

import 'package:at_events/models/event_model.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardEventCalendar extends StatelessWidget {
  final Event event;
  final Function() onTap;

  const CardEventCalendar({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String dateOrHour;
    final String eventDate = DateFormat('dd/MM/yyyy').format(event.date!);
    final String nowDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    if (eventDate == nowDate) {
      dateOrHour = 'Hora: ${DateFormat('h:mm a').format(event.date!)}';
    } else {
      dateOrHour = DateFormat('E, d MMM yyyy h:mm a').format(event.date!);
    }

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
                    Uint8List.fromList(event.uint8Image!),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      Text(dateOrHour),
                      Text(
                        event.place!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      )
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
