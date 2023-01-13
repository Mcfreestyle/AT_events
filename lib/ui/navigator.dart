import 'package:at_events/ui/views/calendar/calendar_view.dart';
import 'package:at_events/ui/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/home/home_view.dart';
import 'package:at_events/ui/views/explorer/explorer_view.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Widget> _widgetOptions = const [
    HomeView(),
    EventCalendarView(),
    ExploreView(),
    ProfileView(),
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = MyColor.primary;
    Color unselectedColor = MyColor.secondary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BottomBar(
        barColor: MyColor.terciary,
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        width: MediaQuery.of(context).size.width * 0.8,
        start: 2,
        end: 0,
        bottom: 10,
        alignment: Alignment.bottomCenter,
        child: TabBar(
          indicatorColor: Colors.white,
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          tabs: [
            TabsIcon(
              icons: Icons.home_filled,
              color: currentPage == 0 ? selectedColor : unselectedColor,
            ),
            TabsIcon(
              icons: Icons.event,
              color: currentPage == 1 ? selectedColor : unselectedColor,
            ),
            TabsIcon(
              icons: Icons.explore,
              color: currentPage == 2 ? selectedColor : unselectedColor,
            ),
            TabsIcon(
              icons: Icons.person,
              color: currentPage == 3 ? selectedColor : unselectedColor,
            ),
          ],
        ),
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: _widgetOptions,
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final IconData icons;
  final Color color;

  const TabsIcon({
    super.key,
    required this.icons,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 40,
      child: Center(
        child: Icon(
          icons,
          color: color,
          size: 30,
        ),
      ),
    );
  }
}
