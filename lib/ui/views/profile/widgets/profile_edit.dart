import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/textfield_widget.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      //backgroundColor: Color.fromARGB(255, 206, 196, 196),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Editar perfil',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),

      body: ListView(
        children: [
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Nombre',
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Apellidos',
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Gmail',
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.number,
                  hintText: 'Celular',
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Distrito',
                ),

                const SizedBox(
                  height: 100,
                ),
                ////////////////////////
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ButtonWidget(
                    title: 'Guardar Cambios',
                    type: 'primary',
                    function: () {
                      /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyNavigator()),
                      );*/
                      //  Navigator.pushReplacementNamed(context, 'perfil_view');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
