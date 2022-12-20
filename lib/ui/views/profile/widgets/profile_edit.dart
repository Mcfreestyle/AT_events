import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 196, 196),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Editar Perfil',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              letterSpacing: 2,
            ),
          ),
        ),        
      ),
      body: Column(
        children: const [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Escribe tu nombre',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Apellidos',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Escribe tu Apellido',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Correo',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Example@gmail.com',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Celular',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Escribe tu numero',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Distrito',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Escribe tu distrito',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Contraseña',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: '',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Confirmar contraseña',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: '',
            ),
          ),
        ],
      ),
    );
  }
}