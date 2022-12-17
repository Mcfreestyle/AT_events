import 'package:flutter/material.dart';

import 'package:at_events/ui/widgets/textfield_widget.dart';
import 'package:at_events/ui/widgets/button_widget.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Empezemos!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  const TextFieldWidget(
                    keyboardType: TextInputType.name,
                    hintText: 'Nombre de usuario',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextFieldWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextFieldWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Contraseña',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextFieldWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Confirme contraseña',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ButtonWidget(
                      title: 'Registrarse',
                      type: 'primary',
                      function: () {
                        Navigator.pushReplacementNamed(
                            context, 'navigator_view');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ButtonWidget(
                      title: 'Iniciar sesión',
                      type: 'secondary',
                      function: () {
                        Navigator.pushReplacementNamed(context, 'login_view');
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
