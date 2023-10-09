import 'package:event_plus/feature/authentication/presentation/screen/home_screen.dart';
import 'package:event_plus/feature/registration/presentation/screen/register_attendee_screen.dart';
import 'package:event_plus/feature/registration/presentation/screen/scan_attendee_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/';
  static const String registerAttendee = '/register-attendee';
  static const String registerEvent = '/register-event';
  static const String scanAttendee = '/scan-attendee';
  static const String event = '/event';
  static const String eventDetail = '/event-detail';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String notFound = '/not-found';
  static const String noInternet = '/no-internet';

  static MaterialPageRoute<dynamic> onGenerateRouter(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case registerAttendee:
        return MaterialPageRoute(
          builder: (_) => const RegisterAttendeeScreen(),
        );
      case scanAttendee:
        return MaterialPageRoute(
          builder: (_) => const ScanAttendeeScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Not Found')),
    );
  }
}
