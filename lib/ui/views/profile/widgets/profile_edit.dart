import 'dart:io';

import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/textfield_widget.dart';

class ProfileFormView extends StatelessWidget {
  const ProfileFormView({super.key});

  ImageProvider setImage(StorageImageProvider storageImage, String imageName) {
    late final ImageProvider image;
    final imageFile = storageImage.image;
    final imageRoute =
        'https://chyazarkkwiioawhxilu.supabase.co/storage/v1/object/public/users/IMG/$imageName';

    if (imageFile != null) {
      image = FileImage(imageFile);
    } else if (imageName == '') {
      image = const AssetImage('assets/images/profile.webp');
      storageImage.imageName = imageName;
    } else {
      image = NetworkImage(imageRoute);
      storageImage.imageName = imageName;
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final storageImage = context.watch<StorageImageProvider>();
    final authService = context.read<AuthService>();
    final user = authService.user;
    final image = setImage(storageImage, user.imageName);

    final userNameController =
        TextEditingController(text: authService.user.userName);
    final nameController = TextEditingController(text: authService.user.name);
    final lastNameController =
        TextEditingController(text: authService.user.lastName);
    final phoneController = TextEditingController(text: authService.user.phone);

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
                SizedBox(
                  height: 150,
                  width: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: image,
                      ),
                      Positioned(
                        bottom: -8,
                        right: 10,
                        child: RawMaterialButton(
                          onPressed: () {
                            _showModalBottomSheet(context);
                          },
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
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Nombre de usuario',
                  controller: userNameController,
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Nombre',
                  controller: nameController,
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Apellidos',
                  controller: lastNameController,
                ),
                SizedBox(
                  height: 14,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.number,
                  hintText: 'Celular',
                  controller: phoneController,
                ),
                // SizedBox(
                //   height: 14,
                // ),
                // TextFieldWidget(
                //   keyboardType: TextInputType.text,
                //   hintText: 'Contraseña',
                //   initialValue: authService.user.password,
                // ),
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
                    onPressed: () async {
                      authService.user.userName = userNameController.text;
                      authService.user.name = nameController.text;
                      authService.user.lastName = lastNameController.text;
                      authService.user.phone = phoneController.text;
                      authService.user.imageName = storageImage.imageName!;

                      if (storageImage.image != null) {
                        await storageImage.uploadUserImageStorage();
                      }
                      await authService.updateUser();
                      storageImage.cleanImage();
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

void _showModalBottomSheet(BuildContext context) {
  final storage = context.read<StorageImageProvider>();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.filter),
            title: const Text('Abrir galeria'),
            onTap: () {
              storage.activeGallery();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Tomar foto'),
            onTap: () {
              storage.activeCamera();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
