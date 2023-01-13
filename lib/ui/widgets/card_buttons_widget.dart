import 'package:at_events/models/event_model.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InterestButton extends StatelessWidget {
  const InterestButton({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final bool isInterested =
        context.select<EventService, bool>((eventService) {
      return eventService.eventsInterestsOfUser
          .any((element) => element.id == event.id);
    });

    return ElevatedButton.icon(
      icon: const Icon(Icons.star),
      label: const Text('Me interesa'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isInterested ? MyColor.primary : MyColor.secondary,
        fixedSize: const Size(150, 35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () async {
        final eventService = context.read<EventService>();
        final authService = context.read<AuthService>();
        final userId = authService.user.id;
        await eventService.verifyInterest(event.id!, userId!);
      },
    );
  }
}

class AttendanceButton extends StatelessWidget {
  const AttendanceButton({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final bool isAssistant = context.select<EventService, bool>((eventService) {
      return eventService.eventsAttendancesOfUser
          .any((element) => element.id == event.id);
    });

    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today_outlined),
      label: const Text('Asistiré'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isAssistant ? MyColor.primary : MyColor.secondary,
        fixedSize: const Size(150, 35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () async {
        final eventService = context.read<EventService>();
        final authService = context.read<AuthService>();
        final userId = authService.user.id;
        await eventService.verifyAttendance(event.id!, userId!);
      },
    );
  }
}
