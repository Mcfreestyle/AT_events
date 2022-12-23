import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/explorer/widgets/card_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabEvents extends StatefulWidget {
  const TabEvents({super.key});

  @override
  State<TabEvents> createState() => _TabEventsState();
}

class _TabEventsState extends State<TabEvents>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final eventService = context.watch<EventService>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: MyColor.secondary,
                indicator: BoxDecoration(
                  color: MyColor.primary,
                  borderRadius: BorderRadius.circular(7),
                ),
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'Libre',
                  ),
                  Tab(
                    text: 'Privado',
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 230,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListView.builder(
                itemCount: eventService.showEvenstByPrice(false).length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final event = eventService.showEvenstByPrice(false)[index];

                  return CardInfo(
                    price: 0,
                    title: event.name!,
                    date: event.date!,
                    place: event.place!,
                    uint8Image: event.uint8Image!,
                    onTap: () {
                      eventService.selectedEvent = event;
                      Navigator.pushNamed(context, 'event_details_view');
                    },
                  );
                },
              ),
              ListView.builder(
                itemCount: eventService.showEvenstByPrice(true).length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final event = eventService.showEvenstByPrice(true)[index];

                  return CardInfo(
                    price: event.price!,
                    title: event.name!,
                    date: event.date!,
                    place: event.place!,
                    uint8Image: event.uint8Image!,
                    onTap: () {
                      eventService.selectedEvent = event;
                      Navigator.pushNamed(context, 'event_details_view');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
