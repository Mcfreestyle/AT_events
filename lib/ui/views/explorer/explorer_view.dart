import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/widgets/card_widget.dart';
import 'package:at_events/ui/views/explorer/widgets/category_widget.dart';
import 'package:at_events/ui/views/explorer/widgets/tab_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Explore',
            style: TextStyle(
              color: Colors.black,
              fontSize: 34.0,
              letterSpacing: 3,
            ),
          ),
          actions: [
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'search_view');
                    },
                    icon: const Icon(
                      CupertinoIcons.search,
                    ),
                    style: _styleIconButton(),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const NavPPage(),
                      //   ),
                      // );
                    },
                    icon: Transform.rotate(
                      angle: 0.6,
                      child: const Icon(
                        Icons.navigation_rounded,
                      ),
                    ),
                    style: _styleIconButton(),
                  ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CatEvent(
                      icon: Image.asset('assets/icons/celebration.png'),
                      text: 'Celebration',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CatEvent(
                      icon: Image.asset('assets/icons/party.png'),
                      text: 'Party',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CatEvent(
                      icon: Image.asset('assets/icons/concert.png'),
                      text: 'Concert',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CatEvent(
                      icon: Image.asset('assets/icons/exhibition.png'),
                      text: 'Exhibition',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CatEvent(
                      icon: Image.asset('assets/icons/food.png'),
                      text: 'Food',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const CardEvent(
                  img: DecorationImage(
                    image: AssetImage('assets/images/showcar.jpg'),
                    fit: BoxFit.cover,
                  ),
                  h1: 'Card Events',
                  h2: '15 feb. 2022',
                  h3: 'Cajamarca',
                  h4: '95 interesados',
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
