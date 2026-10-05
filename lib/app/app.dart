import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class FuelTrackApp extends StatelessWidget {
  const FuelTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'FuelTrack',

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      routerConfig: appRouter,
    );
  }
}