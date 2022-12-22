import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/home/widgets/card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building HomeView');
    final eventService = Provider.of<EventService>(context);
    final storageImage = Provider.of<StorageImageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Home',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {},
            backgroundColor: Colors.white,
            foregroundColor: MyColor.secondary,
            mini: true,
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              Navigator.pushNamed(context, 'form_view');
            },
            backgroundColor: MyColor.primary,
            mini: true,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: eventService.events.length,
        itemBuilder: (BuildContext context, int index) {
          final event = eventService.events[index];

          return FutureBuilder(
            future: storageImage.downloadImageStorage(event.imageName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeEventsCard(
                  name: event.name!,
                  date: event.date!,
                  place: event.place!,
                  image: snapshot.data!,
                  onTap: () {
                    eventService.selectedEvent = event;
                    Navigator.pushNamed(context, 'event_details_view');
                  },
                );
              }
              return const Text('No hay imagen');
            },
          );
        },
      ),
    );
  }
}
