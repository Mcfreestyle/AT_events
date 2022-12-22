import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/profile/widgets/profile_edit.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        // backgroundColor: Color.fromARGB(255, 206, 196, 196),
        appBar: AppBar(
          elevation: 1,
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
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2022/11/16/13/39/cuddly-toys-7596017_960_720.jpg'),
                    ),
                    Positioned(
                      bottom: -8,
                      right: 10,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Color(0xFFF5F6F9),
                        child: Icon(Icons.camera_alt, color: MyColor.primary),
                        padding: EdgeInsets.all(1.0),
                        shape: CircleBorder(),
                      ),
                    )
                  ],
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
                        children: const [
                          Icon(Icons.person),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            ' Alonso',
                            style: TextStyle(
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
                        children: const [
                          Icon(Icons.person),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Arrieta Solis',
                            style: TextStyle(
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
                        children: const [
                          Icon(Icons.phone_android),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '985425412',
                            style: TextStyle(
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
                        children: const [
                          Icon(Icons.location_on),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Surco',
                            style: TextStyle(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PerfilScreen()),
                                );
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
                              child: Text(
                                'Cerrar sesion',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
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
