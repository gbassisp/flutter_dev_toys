import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/view/home.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appName,
      theme: FlexThemeData.light(
        scheme: FlexScheme.jungle,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
          adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
          adaptiveDialogRadius: FlexAdaptive.all(),
          adaptiveElevationShadowsBack: FlexAdaptive.all(),
          adaptiveRadius: FlexAdaptive.all(),
          adaptiveRemoveElevationTint: FlexAdaptive.all(),
          adaptiveRemoveNavigationBarTint: FlexAdaptive.all(),
          adaptiveSplash: FlexAdaptive.all(),
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.jungle,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
          adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
          adaptiveDialogRadius: FlexAdaptive.all(),
          adaptiveElevationShadowsBack: FlexAdaptive.all(),
          adaptiveRadius: FlexAdaptive.all(),
          adaptiveRemoveElevationTint: FlexAdaptive.all(),
          adaptiveRemoveNavigationBarTint: FlexAdaptive.all(),
          adaptiveSplash: FlexAdaptive.all(),
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      // themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
