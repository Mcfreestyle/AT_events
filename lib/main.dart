import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/views/calendar/datails_event.dart';
import 'package:at_events/ui/views/onboarding/onboarding.dart';
import 'package:at_events/ui/views/explorer/explorer_view.dart';
import 'package:at_events/ui/views/profile/profile_view.dart';
import 'package:at_events/ui/views/shared/search/search_view.dart';
import 'package:at_events/ui/views/signup/signup_view.dart';
import 'package:flutter/material.dart';

import 'package:at_events/ui/views/login/login_view.dart';
import 'package:at_events/ui/navigator.dart';
import 'package:at_events/ui/views/home/home_view.dart';
import 'package:provider/provider.dart';
import 'ui/views/shared/event_form_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EventService(),
        ),
        ChangeNotifierProvider(
          create: (context) => StorageImageProvider(),
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
      title: 'Flutter Demo',
      /*theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),*/
      initialRoute: 'login_view',
      routes: {
        'login_view': (_) => const LoginView(),
        'signup_view': (_) => const SignupView(),
        'navigator_view': (_) => const MyNavigator(),
        'home_view': (_) => const HomeView(),
        'form_view': (_) => const EventFormView(),
        'explore_view': (_) => const ExploreView(),
        'search_view': (_) => const SearchView(),
        'onboarding_view': (_) => const OnboardingView(),
        'perfil_view': (_) => const ProfileView(),
        'event_details_view': (_) => const DetailsEvent(),
      },
    );
  }
}
