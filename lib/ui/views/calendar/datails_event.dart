import 'package:at_events/ui/views/calendar/widgets/detail_event_widget.dart';
import 'package:flutter/material.dart';

class DetailsEvent extends StatelessWidget {
  const DetailsEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: const [
          DetailEventWidget(
            imageEvent:
                'https://cdn.pixabay.com/photo/2022/10/17/15/02/photography-7527978_960_720.jpg',
            titleEvent: 'FOTOS AL AIRE LIBRE',
            fechaEvent: ' Martes 2 de Diciembre',
            ubicacionEvent: 'Ubicacion',
            descriptionEvent:
                'To switch to a new route, use the Navigator.push() method. The push() method adds a Route to the stack of routes managed by the Navigator. Where does the Route come from? You can create your own, or use a MaterialPageRoute, which is useful because it transitions to the new route using a platform-specific animation.',
            nameBussinesEvent: 'Empresa Sac',
            numberBussinesEvent: '912345678',
          ),
        ],
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';

class DetailsEvent extends StatelessWidget {
  const DetailsEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 180.0,
                child: Ink.image(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2022/10/17/15/02/photography-7527978_960_720.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(18.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: const [
                            Text('FOTOS AL AIRE LIBRE',
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
                          children: const [
                            Icon(Icons.access_time, size: 17),
                            Text(
                              ' Martes 2 de Diciembre',
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
                            Icon(Icons.location_on_outlined, size: 18),
                            Text(
                              ' Ubicacion del evento',
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
                        child: const Text(
                          'To switch to a new route, use the Navigator.push() method. The push() method adds a Route to the stack of routes managed by the Navigator. Where does the Route come from? You can create your own, or use a MaterialPageRoute, which is useful because it transitions to the new route using a platform-specific animation.',
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
                      const Card(
                        elevation: 0,
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            'Empresa Image',
                            style: TextStyle(fontSize: 13),
                          ),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2021/10/27/13/15/cat-6747298_960_720.jpg')),
                          subtitle: Text('958741234'),
                        ),
                      ),
                      Container(
                        child: Row(children: [
                          Container(
                            height: 30,
                            width: 140,
                            child: MaterialButton(
                              color: Color(0xFFFF3265),
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
                              color: Color(0xFFFF3265),
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Icon(Icons.calendar_month,
                                      color: Colors.white),
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
          )
        ],
      ),
    );
  }
}

 */