import 'package:at_events/routes/route.dart';
import 'package:at_events/services/category_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/widgets/card_widget.dart';
import 'package:at_events/ui/views/explorer/widgets/category_widget.dart';
import 'package:at_events/ui/views/explorer/widgets/tab_widget.dart';
import 'package:at_events/ui/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final eventService = context.read<EventService>();
    final categoryService = Provider.of<CategoryService>(context);
    print('building ExploreView');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Explore',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold, fontSize: 25,
              //fontSize: 34.0,
              //letterSpacing: 3,
            ),
          ),
          actions: [
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingButtonWidget(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.rSEARCH);
                    },
                  ),
                  FloatingButtonWidget(
                    icon: Transform.rotate(
                      angle: 0.6,
                      child: const Icon(
                        Icons.navigation_rounded,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  tab events  */
            const SizedBox(
              width: double.infinity,
              child: TabEvents(),
            ),
            /*  */
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryService.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryService.categories[index];

                  return CatEvent(
                    icon: Image.asset('assets/icons/${category.name}.png'),
                    text: category.name!,
                    onTap: () async {
                      await eventService.showEventsByCategory(category.id!);
                    },
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'Eventos',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            /* lista de eventos */
            Consumer<EventService>(
              builder: (context, service, child) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: service.eventsByCategory.length,
                  itemBuilder: (context, index) {
                    final event = service.eventsByCategory[index];

                    return CardEvent(
                      title: event.name!,
                      date: event.date!,
                      place: event.place!,
                      h4: '95 interesados',
                      uint8Image: event.uint8Image!,
                      onTap: () {
                        eventService.selectedEvent = event;
                        Navigator.pushNamed(context, MyRoutes.rEVENT);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _styleIconButton() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(const CircleBorder()),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      shadowColor: MaterialStateProperty.all(MyColor.secondary),
      elevation: MaterialStateProperty.all(3.5),
    );
  }
}
