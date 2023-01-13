import 'package:at_events/models/event_model.dart';
import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/routes/route.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/category_service.dart';
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
            type: 'secondary',
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingButtonWidget(
            icon: const Icon(Icons.add),
            onPressed: () {
              // final now = DateTime.now();
              // print('zonetime: ${now.timeZoneName}');
              // print('datetime of now: ${now.toLocal()}');
              final storageImage = context.read<StorageImageProvider>();
              storageImage.cleanImage();
              Navigator.pushNamed(context, MyRoutes.rEVENTFORM);
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: const HomeViewBody(),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool isLoading = false;
  bool obtainedEvents = false;

  Future getData(EventService eventService, CategoryService categoryService,
      AuthService authService) async {
    setState(() {
      isLoading = true;
    });
    final events = await eventService.getEvents();
    if (events.isNotEmpty) obtainedEvents = true;
    await eventService.getEventsAttendancesOfUser(authService.user.id!);
    await eventService.getEventsInterestsOfUser(authService.user.id!);
    await categoryService.getCategories();
    print('events loaded in getData: ${eventService.events.toString()}');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('building BodyWidget');

    final authService = context.read<AuthService>();
    final eventService = context.read<EventService>();
    final categoryService = context.read<CategoryService>();
    final events = eventService.events;

    if (events.isEmpty && obtainedEvents == false) {
      print('events is empty');
      getData(eventService, categoryService, authService);
    }

    if (!isLoading) {
      return RefreshIndicator(
        onRefresh: () async {
          await getData(eventService, categoryService, authService);
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
