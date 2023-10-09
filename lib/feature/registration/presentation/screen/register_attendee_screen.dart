import 'package:event_plus/common/constant/app_asset.dart';
import 'package:event_plus/common/routing/app_router.dart';
import 'package:event_plus/feature/authentication/presentation/widget/home_button.dart';
import 'package:event_plus/l10n/l10n.dart';
import 'package:event_plus/util/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RegisterAttendeeScreen extends StatelessWidget {
  const RegisterAttendeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(title: loc.registerEvent),
      ),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: HomeButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.scanAttendee);
            },
            title: loc.scanAttendee,
            assetPath: AppAsset.personIcon,
          ),
        ),
      ),
    );
  }
}
