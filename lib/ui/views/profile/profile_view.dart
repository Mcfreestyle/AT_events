// import 'dart:html';

import 'dart:io';

import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/routes/route.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/profile/widgets/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  ImageProvider setImage(String imageName) {
    late final ImageProvider image;
    final imageRoute =
        'https://chyazarkkwiioawhxilu.supabase.co/storage/v1/object/public/users/IMG/$imageName';

    if (imageName == '') {
      image = const AssetImage('assets/images/profile.webp');
    } else {
      image = NetworkImage(imageRoute);
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    print('building ProfileView');
    final authService = context.watch<AuthService>();
    final user = authService.user;

    final image = setImage(user.imageName);

    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        // backgroundColor: Color.fromARGB(255, 206, 196, 196),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Perfil',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: ListView(
          children: [
            Column(children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 150,
                width: 200,
                child: CircleAvatar(
                  backgroundImage: image,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 206, 196, 196),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            user.userName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${user.name} ${user.lastName}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.phone_android),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            user.phone,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.email),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            width: 100,
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MyColor.primary,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                textStyle: TextStyle(fontSize: 15),
                              ),
                              child: Text(
                                'Editar perfil',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                final storageImage =
                                    context.read<StorageImageProvider>();
                                storageImage.cleanImage();
                                Navigator.pushNamed(
                                    context, MyRoutes.rPROFILEFORM);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              /* -------- segundo cuadro -------- */
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 206, 196, 196),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.shield_moon),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Modo Oscuro',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.question_mark),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Ayuda',
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            width: 100,
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MyColor.primary,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                textStyle: TextStyle(fontSize: 15),
                              ),
                              child: const Text(
                                'Cerrar sesion',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                final eventService =
                                    context.read<EventService>();
                                eventService.events.clear();
                                eventService.eventsAttendancesOfUser.clear();
                                eventService.eventsInterestsOfUser.clear();
                                await authService.closeSession();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.rONBOARDING);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(
              height: 80,
            )
          ],
        ));
  }
}
