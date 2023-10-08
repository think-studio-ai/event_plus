import 'package:event_plus/feature/qr_code_scan/data/qr_code_scanner.dart';
import 'package:event_plus/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../feature/qr_code_scan/presentation/scan_qr_code_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ScanQrCodeScreen(),
    );
  }
}
