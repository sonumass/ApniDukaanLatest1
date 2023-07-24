part of "my_theme.dart";

class MyColors {
  static const MaterialColor appColor = MaterialColor(0xFF305A0D, {
    50: Color(0x86305A0D),
    100: Color(0x11305A0D),
    200: Color(0x22305A0D),
    300: Color(0x33305A0D),
    400: Color(0x44305A0D),
    500: Color(0x55305A0D),
    600: Color(0x66305A0D),
    700: Color(0x77305A0D),
    800: Color(0x88305A0D),
    900: Color(0x99305A0D),
  });
  static const Color themeColor = Color(0xff191B6B);
  static const Color colorPrimary = Color(0xff305A0D);
  static const Color colorPrimaryDark = Color(0xff305A0D);
  static const Color colorTextGrey = Color(0xff7C7C7C);
  static const Color colorTextBlack = Color(0xff000000);
  static const Color coloPageBg = Color(0xFFF5F5F5);
  static const Color buttonColor = appColor;
  static const Color statusBarColor = appColor;
  static const Color transparent = Color(0x00FFFFFF);
  static const Color backgroundWhiteColor = Color(0xffFAFAFA);
  static Color backgroundColor = Color(0xF7216274);
  static Color backgroundColor2 = Color(0xF73195AF);
  static Color buttonsColor = Color(0xF7CC7F00);
  static Color drawerColor = Color(0xF7895501);
  static const Color buttonBorderColor = Color(0xF7FFC971);
  static Color buttonsColor2 = Color(0xF721ACBF);
  static Color buttonlightColor = Color(0xF768A8B9);
  static Color fillColor = Color(0xFFF6F6FE);

  static Color fillDarkColor = Color(0xFFF5F1FD);
  static Color kColorGreen = Colors.green;
  static Color kColorGreenDark = Color(0xFF008E06);
  static Color kColorBlue = Colors.blue;

  static const Color secondaryAppColor = Color(0xFF216274);
  static const Color skyColor = Color(0xFF00CFFF);
  static const Color disableColor = Color.fromRGBO(237, 237, 237, 1.0);
  static const Color kColorBGGrey = Color(0xFFF9F9F9);
  static const Color kColorWhite = Color(0xFFFFFFFF);
  static const Color pink = Color(0xFFE44C7D);
  static const Color blue = Color(0xFFAD5CE1);
  static const Color yellowCard = Color(0xFFDFBA2E);

  static const Color kColorLightWhite = Color(0xFFF2F2F1);
  static const Color ColorBackgraundWhite = Color(0xFFF8FCFD);
  static const Color kColorGold = Color(0xFFA97625);
  static Color kColorExtraLightGrey = Color(0xFFC4C4DB);

  //static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);

  // static const Color kColorExtraLightGrey = Color(0x14002126);
  static const Color kTextColorBlack = Color(0x99002126);
  static const Color kTextColorBlue = Color(0xFF141F47);
  static Color kColorSemiBlack = Color(0x88000000);
  static Color kColorLightBlack = Color(0x76000000);
  static Color kColorSemiLightBlack = Color(0x66000000);
  static Color kColorExtraLightBlack = Color(0x30000000);
  static Color kColorGrey = Colors.grey;
  static const Color kColorDarkGrey = Color(0xFF282828);
  static Color kColorLightGrey = Color(0xF1282828);
  static Color kColorLightGreyAlpha = Color(0x99AAAAAA);

  //static  Color kColorExtraLightGrey = Color(0xFFC4C4DB);

  static Color kColorBorderGrey = Color(0xFFACA7A6);

  // static  Color kColorPurple = Color(0xFF85BD00);
  static Color kColorLightGreen = Color(0xFFA0F9A0);
  static Color kColorLightBGPurple = Color(0xFFF4F3FF);
  static Color kColorLightBGGreen = Color(0xFFE7FCE8);
  static Color kColorLightBGreen = Color(0xFFDEEED8);

  static Color kColorOrange = Color(0xFFFFBE00);
  static Color kColorBorder = Color(0x33000000);
  static Color kColorRed = Color(0xFFFD0303);
  static Color kColorLightRed = Color(0xFFFAD9D9);

  // static  Color kColorLightBGRed = Color(0xFAD9D9FF);
  static Color lineColor = Color.fromRGBO(241, 241, 241, 1);

  static const Color kColorBlack = Colors.black;
  static const Color kColorBlack50 = Color(0x05000000);
  static const Color kColorBlack100 = Color(0x10000000);
  static const Color kColorBlack200 = Color(0x22000000);
  static const Color kColorBlack300 = Color(0x38000000);
  static const Color kColorBlack400 = Color(0x40000000);
  static const Color kColorBlack500 = Color(0x55000000);
  static const Color kColorBlack600 = Color(0x66000000);
  static const Color kColorBlack700 = Color(0x70000000);
  static const Color kColorBlack800 = Color(0x88000000);
  static const Color kColorBlack900 = Color(0x99000000);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
