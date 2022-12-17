import 'package:at_events/ui/views/shared/search/widgets/textformfield_widget.dart';
import 'package:at_events/ui/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
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
