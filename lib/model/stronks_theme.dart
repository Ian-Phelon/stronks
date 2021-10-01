import 'package:flutter/material.dart';
import 'dart:io' as io;

import '../constants.dart';

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
const TextStyle kCommonDarkThemeTextStyle = TextStyle(
  color: kcolorDarkModePrimaryLight,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.bold,
);

/// Light mode equivalent theme use above each THEME>TEXTTHEME>COLORSCHEME
///
/// primarycolor>color>primary
const kcolorDarkModePrimary = Color(0xFF474070);

/// primarycolorlight>null>onBG,onSecondary
const kcolorDarkModePrimaryLight = Color(0xFFDBD5FF);

/// really is primaryBold(bold as in visible, not text)
const kcolorDarkModePrimaryDark = Color(0xFFC1B6FF);
const kcolorDarkModeSecondary = Color(0xFF8B7075);
const kcolorDarkModeSecondaryLight = Color(0xFF6E616D);
const kcolorDarkModeSecondaryDark = Color(0xffCB8E9A);
const kcolorDarkModeError = Colors.white;

class StronksTheme {
  static final togglesForDarkMode = ToggleButtonsThemeData();

  /// currently only using less opaque versions of kcolorDarkModeSecondaryDark
  /// for selectionColor
  static final textCursorAndSelection = TextSelectionThemeData(
    cursorColor: kcolorPrimaryDark,
    selectionColor: Color.fromARGB(52, 0xCb, 0x8e, 0x9a),
    selectionHandleColor: Color.fromARGB(52, 0xCb, 0x8e, 0x9a),
  );
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
      textSelectionTheme: textCursorAndSelection,
      platform: isIos ? TargetPlatform.iOS : TargetPlatform.android,
      brightness: Brightness.light,
      primaryColor: kcolorPrimary,
      primaryColorDark: kcolorPrimaryDark,
      primaryColorLight: kcolorPrimaryLight,
      fontFamily: kFontFamily,
      shadowColor: kcolorPrimaryDark,
      splashColor: kcolorPrimaryLight,
      hoverColor: kcolorPrimaryLight,
      focusColor: kcolorPrimaryLight,
      indicatorColor: kcolorPrimaryLight,
      highlightColor: kcolorPrimaryLight,
      buttonTheme: ButtonThemeData(splashColor: Colors.pink),

      ///Tab bar theme, currently used in stats/calendar
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: kcolorPrimaryDark,
        unselectedLabelStyle: kCommonLightThemeTextStyle,
        labelColor: kcolorPrimaryDark,
        labelStyle: kCommonLightThemeTextStyle.copyWith(
          fontStyle: FontStyle.italic,
          fontSize: 20,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: kcolorPrimaryDark,
            width: 4.4,
            style: BorderStyle.solid,
          ),
          insets: EdgeInsets.zero,
        ),
      ),

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
    TextTheme textTheme = const TextTheme(
      headline1: kCommonDarkThemeTextStyle,
      headline2: const TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: kFontFamily,
        color: kcolorDarkModePrimaryLight,
      ),
      headline3: kCommonDarkThemeTextStyle,
      headline4: kCommonDarkThemeTextStyle,
      headline5: kCommonDarkThemeTextStyle,
      headline6: kCommonDarkThemeTextStyle,
    );
    return ThemeData(
      // toggleButtonsTheme: ToggleButtonsThemeData(),
      textSelectionTheme: textCursorAndSelection,
      platform: isIos ? TargetPlatform.iOS : TargetPlatform.android,
      brightness: Brightness.dark,
      primaryColor: kcolorDarkModePrimary,
      primaryColorDark: kcolorDarkModePrimaryDark,
      primaryColorLight: kcolorDarkModePrimaryLight,
      fontFamily: kFontFamily,
      shadowColor: kcolorPrimaryDark,

      ///Tab bar theme, currently used in stats/calendar
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: kcolorDarkModePrimaryLight,
        unselectedLabelStyle: kCommonLightThemeTextStyle,
        labelColor: kcolorDarkModePrimaryLight,
        labelStyle: kCommonLightThemeTextStyle.copyWith(
          fontStyle: FontStyle.italic,
          fontSize: 20,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: kcolorDarkModePrimaryLight,
            width: 4.4,
            style: BorderStyle.solid,
          ),
          insets: EdgeInsets.zero,
        ),
      ),

      /// largest headline2, smallest headline6
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        color: kcolorDarkModePrimary,
        centerTitle: true,
      ),
      colorScheme: ColorScheme(
        /// A color that typically appears behind scrollable content.
        background: kcolorDarkModeSecondary,

        /// .This is the light theme
        brightness: Brightness.dark,

        /// The color to use for input validation errors, e.g. for
        /// [InputDecoration.errorText].
        error: kcolorDarkModeError,

        /// A color that's clearly legible when drawn on [background].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [background]
        /// and [onBackground] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onBackground: kcolorDarkModePrimaryLight,

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
        onPrimary: kcolorDarkModeSecondaryLight,

        /// A color that's clearly legible when drawn on [secondary].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [secondary]
        /// and [onSecondary] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onSecondary: kcolorDarkModePrimaryLight,

        /// A color that's clearly legible when drawn on [surface].
        ///
        /// To ensure that an app is accessible, a contrast ratio of 4.5:1 for [surface]
        /// and [onSurface] is recommended. See
        /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
        onSurface: kcolorDarkModePrimaryDark,

        /// The color displayed most frequently across your app’s screens and components.
        primary: kcolorDarkModePrimary,

        /// darker primary
        primaryVariant: kcolorDarkModePrimaryDark,

        /// An accent color that, when used sparingly, calls attention to parts
        /// of your app.
        secondary: kcolorDarkModeSecondary,

        /// darker secondary
        secondaryVariant: kcolorDarkModeSecondaryDark,

        /// The background color for widgets like [Card].
        surface: kcolorDarkModeSecondaryLight,
      ),
    );
  }
}
