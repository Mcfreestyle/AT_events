import 'package:at_events/utils/snack_bar_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:at_events/routes/route.dart';
import 'package:at_events/services/auth_service.dart';
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
    final authService = context.read<AuthService>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: Image.asset(
                    'assets/icons/logo_at_event.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      TextFieldWidget(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        onChanged: (value) => authService.user.email = value,
                        validator: (value) {
                          String characters =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                          RegExp regExp = RegExp(characters);

                          return regExp.hasMatch(value ?? '')
                              ? null
                              : 'No es un correo valido';
                        },
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
                        onChanged: (value) => authService.user.password = value,
                        validator: (value) {
                          return (value != null && value.length >= 6)
                              ? null
                              : 'Debe tener minimo 6 caracteres';
                        },
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
                          onPressed: () async {
                            if (formkey.currentState?.validate() == false) {
                              return;
                            }

                            final response = await authService.login();
                            if (response != null) {
                              print(response);
                              SnackBarMsg.appearSnackBar(
                                  'Credenciales incorrectos',
                                  type: 'alert');
                              return null;
                            }
                            SnackBarMsg.appearSnackBar('Bienvenido');
                            // ignore: use_build_context_synchronously
                            Navigator.popAndPushNamed(
                                context, MyRoutes.rNAVIGATOR);
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
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, MyRoutes.rSIGNUP);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
