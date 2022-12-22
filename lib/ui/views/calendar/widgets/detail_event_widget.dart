import 'dart:typed_data';

import 'package:at_events/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class DetailEventWidget extends StatelessWidget {
  final Uint8List? imageEvent;
  final String? titleEvent;
  final String? fechaEvent;
  final String? hoursEvent;
  final String? ubicacionEvent;
  final String? descriptionEvent;
  final String? nameBussinesEvent;
  final String? numberBussinesEvent;

  const DetailEventWidget(
      {Key? key,
      this.imageEvent,
      this.titleEvent,
      this.hoursEvent,
      this.ubicacionEvent,
      this.descriptionEvent,
      this.nameBussinesEvent,
      this.numberBussinesEvent,
      this.fechaEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 180.0,
            // child: Ink.image(
            //   image: NetworkImage('$imageEvent'),
            //   fit: BoxFit.cover,
            // ),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.memory(
                Uint8List.fromList(imageEvent!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(18.0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text('$titleEvent',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 17),
                        Text(
                          '$fechaEvent',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 18),
                        Text(
                          ' $ubicacionEvent',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Icon(Icons.people_alt_outlined, size: 18),
                        Text(
                          ' 80 asistente   120 interesados',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Text(
                          'Acerca del evento',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      '$descriptionEvent',
                      // 'To switch to a new route, use the Navigator.push() method. The push() method adds a Route to the stack of routes managed by the Navigator. Where does the Route come from? You can create your own, or use a MaterialPageRoute, which is useful because it transitions to the new route using a platform-specific animation.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Text(
                          'Contacto',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        '$nameBussinesEvent',
                        style: TextStyle(fontSize: 13),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2021/10/27/13/15/cat-6747298_960_720.jpg')),
                      subtitle: Text('$numberBussinesEvent'),
                    ),
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                        height: 30,
                        width: 140,
                        child: MaterialButton(
                          color: MyColor.primary,
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.grade, color: Colors.white),
                              Text(
                                ' Me interesa',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          height: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        height: 30,
                        width: 120,
                        child: MaterialButton(
                          color: MyColor.primary,
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.calendar_month, color: Colors.white),
                              Text(
                                ' Asistire',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
