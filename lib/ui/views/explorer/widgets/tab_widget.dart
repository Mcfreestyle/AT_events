import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/explorer/widgets/card_info_widget.dart';
import 'package:flutter/material.dart';

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
                itemCount: 5,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const CardInfo(
                    decorationImage: DecorationImage(
                      image: AssetImage('assets/images/showcar.jpg'),
                      fit: BoxFit.cover,
                    ),
                    costo: '',
                    h1: 'Car Expo',
                    h2: '15 Dic 2022',
                    h3: 'Lima',
                  );
                },
              ),
              ListView.builder(
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const CardInfo(
                    decorationImage: DecorationImage(
                      image: AssetImage('assets/images/showcar.jpg'),
                      fit: BoxFit.cover,
                    ),
                    costo: 'S/. 30',
                    h1: 'Car Expo',
                    h2: '15 Dic 2022',
                    h3: 'Lima',
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
