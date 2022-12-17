import 'package:flutter/material.dart';

import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/home/widgets/card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeEventsCard(),
            HomeEventsCard(),
            HomeEventsCard(),
          ],
        ),
      ),
    );
  }
}
