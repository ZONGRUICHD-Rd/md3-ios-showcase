import 'package:flutter/material.dart';
import 'pages/home_shell.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const Md3ShowcaseApp());
}

class Md3ShowcaseApp extends StatefulWidget {
  const Md3ShowcaseApp({super.key});

  @override
  State<Md3ShowcaseApp> createState() => _Md3ShowcaseAppState();
}

class _Md3ShowcaseAppState extends State<Md3ShowcaseApp> {
  final AppThemeController _themeController = AppThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'MD3 iOS Showcase',
          debugShowCheckedModeBanner: false,
          themeMode: _themeController.themeMode,
          theme: _themeController.buildTheme(Brightness.light),
          darkTheme: _themeController.buildTheme(Brightness.dark),
          builder: (BuildContext context, Widget? appChild) {
            final MediaQueryData mq = MediaQuery.of(context);
            return MediaQuery(
              data: mq.copyWith(
                textScaler: TextScaler.linear(_themeController.textScale),
              ),
              child: appChild ?? const SizedBox.shrink(),
            );
          },
          home: HomeShell(themeController: _themeController),
        );
      },
    );
  }
}
