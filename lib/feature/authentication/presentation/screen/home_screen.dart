import 'package:event_plus/common/routing/app_router.dart';
import 'package:event_plus/feature/authentication/presentation/widget/home_button.dart';
import 'package:event_plus/util/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Home'),
      ),
      body: Center(
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 2,
              child: HomeButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.registerAttendee);
                },
                title: 'Register Attendee',
                assetPath: 'assets/images/attendee.png',
              ),
            ),
           const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: HomeButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.event);
                },
                title: 'Register Event',
                assetPath: 'assets/images/speaker.png',
              ),
            ),
            const Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
