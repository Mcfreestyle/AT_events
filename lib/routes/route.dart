import 'package:at_events/ui/verify_auth.dart';
import 'package:at_events/ui/views/profile/widgets/profile_edit.dart';
import 'package:flutter/material.dart';

import 'package:at_events/ui/views/index.dart';

class MyRoutes {
  static const String rONBOARDING = '/onboarding_view';
  static const String rLOGIN = '/login_view';
  static const String rSIGNUP = '/signup_view';
  static const String rNAVIGATOR = '/navigator_view';
  static const String rHOME = '/home_view';
  static const String rEVENTFORM = '/event_form_view';
  static const String rCALENDAR = '/calendar_view';
  static const String rEXPLORE = '/explore_view';
  static const String rSEARCH = '/search_view';
  static const String rPROFILE = '/profile_view';
  static const String rPROFILEFORM = '/profile_form_view';
  static const String rEVENT = '/event_details_view';
  static const String rVERIFY = '/verify';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboarding_view':
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case '/login_view':
        return MaterialPageRoute(builder: (_) => const LoginView());
      case '/signup_view':
        return MaterialPageRoute(builder: (_) => const SignupView());
      case '/navigator_view':
        return MaterialPageRoute(builder: (_) => const MyNavigator());
      case '/home_view':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/event_form_view':
        return MaterialPageRoute(builder: (_) => const EventFormView());
      case '/calendar_view':
        return MaterialPageRoute(builder: (_) => const EventCalendarView());
      case '/explore_view':
        return MaterialPageRoute(builder: (_) => const ExploreView());
      case '/search_view':
        return MaterialPageRoute(builder: (_) => const SearchView());
      case '/profile_view':
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case '/profile_form_view':
        return MaterialPageRoute(builder: (_) => const ProfileFormView());
      case '/event_details_view':
        return MaterialPageRoute(builder: (_) => const DetailsEvent());
      default:
        return MaterialPageRoute(builder: (_) => const MyNavigator());
    }
  }

  static Map<String, Widget Function(BuildContext)> routes = {
    rVERIFY: (_) => const VerifyAuth(),
    rONBOARDING: (_) => const OnboardingView(),
    rLOGIN: (_) => const LoginView(),
    rSIGNUP: (_) => const SignupView(),
    rNAVIGATOR: (_) => const MyNavigator(),
    rHOME: (_) => const HomeView(),
    rCALENDAR: (_) => const EventCalendarView(),
    rEXPLORE: (_) => const ExploreView(),
    rSEARCH: (_) => const SearchView(),
    rPROFILE: (_) => const ProfileView(),
    rEVENTFORM: (_) => const EventFormView(),
    rPROFILEFORM: (_) => const ProfileFormView(),
    rEVENT: (_) => const DetailsEvent(),
  };
}
