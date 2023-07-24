part of "my_theme.dart";

class AppTheme {
  static bool isDarkMode = false;

  static ThemeData themeData(context, {bool isDarkTheme = false}) {
    TextTheme textTheme = TextTheme(
      headline1: MyTextStyle.headline1,
      headline2: MyTextStyle.headline2,
      headline3: MyTextStyle.headline3,

      /// light text
      headline4: MyTextStyle.headline4,
      headline5: MyTextStyle.headline5,
      headline6: MyTextStyle.headline6,
      subtitle1: MyTextStyle.title,

      /// bold text
      subtitle2: MyTextStyle.subtitle,

      /// semi bold
      bodyText1: MyTextStyle.body1,
      bodyText2: MyTextStyle.body2,

      /// label
      caption: MyTextStyle.caption,

      /// caption
    );

    return ThemeData(
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: MyColors.appColor,
      ),
      // for others(Android, Fuchsia)
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.appColor,
          selectionColor: MyColors.appColor,
          selectionHandleColor: MyColors.appColor),
      primarySwatch: MyColors.appColor,
      primaryColor: isDarkTheme ? Colors.black : MyColors.appColor,

      backgroundColor: isDarkTheme ? Colors.black : Colors.white,

      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : Color(0xFF3F51B5),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : const Color(0xFF3F51B5),

      hintColor: isDarkTheme ? Color(0xff280C0B) : Colors.black,

      highlightColor: isDarkTheme ? Color(0xFFFFFFFF) : Color(0x22F16A36),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xFF3F51B5),
//      iconTheme: IconTheme(data: IconThemeData(), child: null),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0x00FFAC30),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Color(0x00FFAC30),
      canvasColor: isDarkTheme ? Colors.black : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColors.appColor,
            statusBarIconBrightness: Brightness.light),
      ),
      textTheme: textTheme,
    );
  }
}
