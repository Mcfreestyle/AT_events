import 'package:at_events/routes/route.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyAuth extends StatelessWidget {
  const VerifyAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Text(
                'Espere...',
                style: TextStyle(
                  fontSize: 28,
                ),
              );
            }
            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, MyRoutes.rONBOARDING, (route) => false);
              });
            } else {
              Future.microtask(() async {
                final user = await authService.getUser();
                if (user == null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyRoutes.rONBOARDING, (route) => false);
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyRoutes.rNAVIGATOR, (route) => false);
                }
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
