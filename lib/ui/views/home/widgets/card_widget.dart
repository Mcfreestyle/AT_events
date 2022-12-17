import 'package:flutter/material.dart';

import 'package:at_events/ui/theme/colors.dart';

class HomeEventsCard extends StatelessWidget {
  const HomeEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              const FadeInImage(
                placeholder: AssetImage('assets/gifs/loading.gif'),
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2016/11/23/15/48/audience-1853662_960_720.jpg'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Concierto de rock',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Viernes, 16 de Diciembre, 8 pm',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Jardin de la cerveza',
                      style: TextStyle(color: MyColor.secondary),
                    ),
                    Text(
                      '60 interesados - 50 asistirán',
                      style: TextStyle(color: MyColor.secondary),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.star),
                          label: const Text('Me interesa'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.secondary,
                            fixedSize: const Size(140, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {},
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.calendar_today_outlined),
                          label: const Text('Asistiré'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.secondary,
                            fixedSize: const Size(140, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
