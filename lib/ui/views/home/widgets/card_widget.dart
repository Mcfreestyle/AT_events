import 'dart:typed_data';

import 'package:at_events/models/event_model.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/widgets/card_buttons_widget.dart';
import 'package:flutter/material.dart';

import 'package:at_events/ui/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeEventsCard extends StatelessWidget {
  final Function()? onTap;
  final Event event;

  const HomeEventsCard({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print('building HomeEventCard');
    // final eventService = context.read<EventService>();
    // final authService = context.read<AuthService>();

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
                    Uint8List.fromList(event.uint8Image!),
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
                        event.name!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('E, d MMM yyyy h:mm a').format(event.date!),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        event.place!,
                        style: TextStyle(color: MyColor.secondary),
                      ),
                      EventAttendancesAndInterests(event: event),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InterestButton(event: event),
                          AttendanceButton(event: event)
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

class EventAttendancesAndInterests extends StatelessWidget {
  const EventAttendancesAndInterests({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final attendance = context.select<EventService, int>((eventService) {
      final matchedEvent =
          eventService.events.firstWhere((element) => element.id == event.id);
      return matchedEvent.attendance!;
    });
    final interested = context.select<EventService, int>((eventService) {
      final matchedEvent =
          eventService.events.firstWhere((element) => element.id == event.id);
      return matchedEvent.interested!;
    });

    return Text(
      '$interested interesados - $attendance asistirán',
      style: TextStyle(color: MyColor.secondary),
    );
  }
}
