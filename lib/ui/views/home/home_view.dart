import 'package:at_events/models/event_model.dart';
import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/routes/route.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/ui/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/home/widgets/card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building HomeView');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          FloatingButtonWidget(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              final storageImage = context.read<StorageImageProvider>();
              storageImage.cleanImage();
              Navigator.pushNamed(context, MyRoutes.rEVENTFORM);
            },
            backgroundColor: MyColor.primary,
            mini: true,
            child: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: const BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  bool isLoading = false;

  Future getEvents(EventService eventService, AuthService authService) async {
    setState(() {
      isLoading = true;
    });
    // eventService.events.clear();
    // print('events after clearing: ${eventService.events.toString()}');
    await eventService.getEvents();
    await eventService.getEventsAttendancesOfUser(authService.user.id!);
    await eventService.getEventsInterestsOfUser(authService.user.id!);
    print('events loaded: ${eventService.events.toString()}');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('building BodyWidget');

    final authService = context.read<AuthService>();
    final eventService = context.read<EventService>();
    final events = eventService.events;

    if (events.isEmpty) {
      print('events is empty');
      getEvents(eventService, authService);
    }

    if (!isLoading) {
      return RefreshIndicator(
        onRefresh: () async {
          await getEvents(eventService, authService);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return _ListViewItem(index);
            },
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class _ListViewItem extends StatelessWidget {
  final int index;

  const _ListViewItem(this.index);

  @override
  Widget build(BuildContext context) {
    print('building ListViewItem');
    final event = context.select<EventService, Event>((eventService) {
      return eventService.events[index];
    });
    return HomeEventsCard(
      event: event,
      onTap: () {
        final eventService = context.read<EventService>();
        eventService.selectedEvent = event;
        Navigator.pushNamed(context, MyRoutes.rEVENT);
      },
    );
  }
}
