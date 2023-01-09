import 'dart:typed_data';

import 'package:at_events/models/event_model.dart';
import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/index.dart';
import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:at_events/ui/widgets/card_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailEventWidget extends StatelessWidget {
  final bool edition;
  final Event event;

  const DetailEventWidget({
    Key? key,
    required this.event,
    required this.edition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final userId = authService.user.id;

    return Container(
      child: Column(
        children: [
          Container(
            height: 180.0,
            // child: Ink.image(
            //   image: NetworkImage('$imageEvent'),
            //   fit: BoxFit.cover,
            // ),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.memory(
                Uint8List.fromList(event.uint8Image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(18.0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(event.name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 17),
                        Text(
                          DateFormat('E, d MMM yyyy h:mm a')
                              .format(event.date!),
                          style: TextStyle(fontSize: 12),
                        ),
                        const Expanded(child: SizedBox()),
                        (edition && userId == event.userId)
                            ? SizedBox(
                                width: 80,
                                height: 20,
                                child: ButtonWidget(
                                  title: 'Editar',
                                  type: 'secondary',
                                  fontSize: 12,
                                  onPressed: () {
                                    final storageImage =
                                        context.read<StorageImageProvider>();
                                    storageImage.cleanImage();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            EventFormView(event: event),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 18),
                        Text(
                          event.place!,
                          style: TextStyle(fontSize: 12),
                        ),
                        const Expanded(child: SizedBox()),
                        (edition && userId == event.userId)
                            ? SizedBox(
                                width: 80,
                                height: 20,
                                child: ButtonWidget(
                                  title: 'Eliminar',
                                  type: 'secondary',
                                  fontSize: 12,
                                  onPressed: () {},
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        const Icon(Icons.people_alt_outlined, size: 18),
                        EventAttendancesAndInterests(event: event)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Text(
                          'Acerca del evento',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      event.description!,
                      // 'To switch to a new route, use the Navigator.push() method. The push() method adds a Route to the stack of routes managed by the Navigator. Where does the Route come from? You can create your own, or use a MaterialPageRoute, which is useful because it transitions to the new route using a platform-specific animation.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Text(
                          'Contacto',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        'FOO',
                        style: TextStyle(fontSize: 13),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2021/10/27/13/15/cat-6747298_960_720.jpg')),
                      subtitle: Text('FOO'),
                    ),
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                          height: 30,
                          width: 140,
                          child: InterestButton(event: event)),
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                          height: 30,
                          width: 120,
                          child: AttendanceButton(event: event)),
                    ]),
                  )
                ],
              )),
        ],
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
