import 'package:at_events/services/auth_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/utils/snack_bar_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:at_events/routes/route.dart';
import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/category_service.dart';
import 'package:at_events/services/event_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => StorageImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryService(),
        ),
        ChangeNotifierProxyProvider<StorageImageProvider, EventService>(
          create: (context) => EventService(),
          update: ((context, storage, service) {
            if (service == null) throw ArgumentError.notNull('service');
            service.storageImage = storage;
            return service;
          }),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: SnackBarMsg.msgKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.pink,
      ),
      // onGenerateRoute: MyRoutes.generateRoute,
      initialRoute: MyRoutes.rVERIFY,
      routes: MyRoutes.routes,
    );
  }
}
