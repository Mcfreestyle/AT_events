import 'package:at_events/routes/route.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/views/shared/search/widgets/textformfield_widget.dart';
import 'package:at_events/ui/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final eventService = Provider.of<EventService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 130,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: CustomTextFormField(
                    hintText: 'Busqueda de eventos',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Hero(
              tag: 'search',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.search),
                style: _styleIconButton(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: eventService.events.length,
        itemBuilder: (context, index) {
          final event = eventService.events[index];

          return CardEvent(
            title: event.name!,
            date: event.date!,
            place: event.place!,
            interested: event.interested!,
            uint8Image: event.uint8Image!,
            onTap: () {
              eventService.selectedEvent = event;
              Navigator.pushNamed(context, MyRoutes.rEVENT);
            },
          );
        },
      ),
    );
  }

  ButtonStyle _styleIconButton() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(const CircleBorder()),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      //shadowColor: MaterialStateProperty.all(Colores.black1),
      elevation: MaterialStateProperty.all(3.5),
    );
  }
}
