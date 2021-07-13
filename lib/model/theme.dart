import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:stronks/constants.dart';

final bool isIos = io.Platform.isIOS;

const TextStyle kCommonLightThemeTextStyle = TextStyle(
  color: kcolorPrimaryDark,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.bold,
);

/// Light Mode
const kcolorPrimary = Color(0xff6654d1);
const kcolorPrimaryLight = Color(0xff9982FF);
const kcolorPrimaryDark = Color(0xff2A2B9F);
const kcolorSecondary = Color(0xffFFBFCB);
const kcolorSecondaryLight = Color(0xffFFF2FE);
const kcolorSecondaryDark = Color(0xffCB8E9A);
const kcolorError = Color(0xffF55454);

/// Dark Mode
/// lul

class StronksTheme {
  static ThemeData get lightMode {
    TextTheme textTheme = const TextTheme(
      headline1: kCommonLightThemeTextStyle,
      headline2: const TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: kFontFamily,
        color: kcolorPrimaryDark,
      ),
      headline3: kCommonLightThemeTextStyle,
      headline4: kCommonLightThemeTextStyle,
      headline5: kCommonLightThemeTextStyle,
      headline6: kCommonLightThemeTextStyle,
    );
    return ThemeData(
      // toggleButtonsTheme: ToggleButtonsThemeData(),
      platform: isIos ? TargetPlatform.iOS : TargetPlatform.android,
      brightness: Brightness.light,
      primaryColor: kcolorPrimary,
      primaryColorDark: kcolorPrimaryDark,
      primaryColorLight: kcolorPrimaryLight,
      fontFamily: kFontFamily,

      /// largest headline2, smallest headline6
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        color: kcolorPrimary,
        centerTitle: true,
      ),
      colorScheme: ColorScheme(
        /// A color that typically appears behind scrollable content.
        background: kcolorSecondary,

        /// .This is the light theme
        brightness: Brightness.light,

        /// The color to use for input validation errors, e.g. for
        /// [InputDecoration.errorText].
        error: kcolorError,

        /// A color that's clearly legible when drawn on [background].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [background]
        /// and [onBackground] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onBackground: kcolorPrimaryLight,

        /// A color that's clearly legible when drawn on [error].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [error]
        /// and [onError] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onError: Colors.black,

        /// A color that's clearly legible when drawn on [primary].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [primary]
        /// and [onPrimary] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onPrimary: kcolorSecondaryLight,

        /// A color that's clearly legible when drawn on [secondary].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [secondary]
        /// and [onSecondary] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onSecondary: kcolorPrimaryLight,

        /// A color that's clearly legible when drawn on [surface].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [surface]
        /// and [onSurface] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onSurface: kcolorPrimaryDark,

        /// The color displayed most frequently across your app’s screens and components.
        primary: kcolorPrimary,

        /// darker primary
        primaryVariant: kcolorPrimaryDark,

        /// An accent color that, when used sparingly, calls attention to parts
        /// of your app.
        secondary: kcolorSecondary,

        /// darker secondary
        secondaryVariant: kcolorSecondaryDark,

        /// The background color for widgets like [Card].
        surface: kcolorSecondaryLight,
      ),
    );
  }

  static ThemeData get darkMode {
    return ThemeData(
      platform: isIos ? TargetPlatform.iOS : TargetPlatform.android,
      brightness: Brightness.dark,
    );
  }
}
