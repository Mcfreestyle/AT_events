import 'package:flutter/material.dart';

import 'package:at_events/ui/widgets/textfield_widget.dart';
import 'package:at_events/ui/widgets/button_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool hiddenPassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
                'Bienvenido!',
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
              key: formkey,
              child: Column(
                children: [
                  const TextFieldWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Contraseña',
                    obscureText: hiddenPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hiddenPassword = !hiddenPassword;
                        });
                      },
                      icon: hiddenPassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ButtonWidget(
                      title: 'Iniciar sesión',
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
                      title: 'Registrarse',
                      type: 'secondary',
                      function: () {
                        Navigator.pushReplacementNamed(context, 'signup_view');
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
