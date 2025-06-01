import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:google_fonts/google_fonts.dart';

class _TextStyles {
  final _Colors colors;

  _TextStyles(this.colors);

  static const productSans = "ProductSans";

  // static const roboto = "Roboto";

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    headline5: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    subtitle1: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    subtitle2: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyText1: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    bodyText2: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    caption: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    overline: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    button: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );

  TextStyle get kTitleStyle => TextStyle(
        fontSize: 20,
        color: colors.appTextColorPrimary,
        fontWeight: FontWeight.bold,
        fontFamily: productSans,
      );

  TextStyle get kSubtitleStyle => TextStyle(
        fontSize: 16,
        color: colors.appSubTitleTextColor,
        fontFamily: productSans,
      );

  TextStyle get kBordStyle => TextStyle(
        fontSize: 12,
        color: colors.dartBlue,
        fontWeight: FontWeight.bold,
        fontFamily: productSans,
      );

  TextStyle get kBordStyleIndexText => TextStyle(
        fontSize: 9,
        color: colors.dartBlue,
        fontWeight: FontWeight.bold,
        fontFamily: productSans,
      );

  TextStyle get kmininStyle => TextStyle(
        fontSize: 9,
        color: colors.appTextColorSecondary,
        fontWeight: FontWeight.w100,
        fontFamily: productSans,
      );
}

class _Colors {
  Color get mPrimaryColor => const Color(0xFFfe5633);

  Color get screenBackGroundColor => const Color(0xFFfcf3ef);

  Color get mBackgroundColor => const Color(0xFFFFFFFF);

  Color get mPrimaryTextColor => const Color(0xFF303030);

  Color get mButtonEmailColor => const Color(0xFF4285F4);

  Color get mBlue => const Color.fromARGB(108, 5, 103, 224);

  Color get mButtonFacebookColor => const Color(0xFF0568e0);

  Color get kYellowColor => const Color(0xFFFFE848);

  Color get mButtonAppleColor => const Color(0xFF001000);

  Color get mBorderColor => const Color(0xFFE8E8E8);

  Color get successColor => const Color(0xFF00d350);

  Color get contentTextColor => const Color(0xff868686);

  Color get appTextColorPrimary => const Color(0xFF212121);

  Color get appSubTitleTextColor => const Color(0xFF88869f);

  Color get iconColorPrimary => const Color(0xFFFFFFFF);

  Color get appTextColorSecondary => const Color(0xFF5e6370);

  Color get iconColorSecondary => const Color(0xFFebf2fa);

  Color get appLayoutBackground => const Color(0xFFf8f8f8);

  Color get appWhite => const Color(0xFFFFFFFF);

  Color get appShadowColor => const Color(0x95E9EBF0);

  Color get dartBlue => const Color(0xFF01002f);
}

class _Assets {
  // splash screen assets
  String get logo => "assets/icons/shopeein.png";
  String get logo1 => "assets/icons/Launching_Icon_App.png";
  String get logo2 => "assets/icons/Logo2.png";

  // login screen assets

  String get shopeeinBag => "assets/images/shopeein.png";

  String get launching_Icon_App => "assets/images/launching_icon_app.png";

  String get categories => "assets/images/categories.png";

  String get fanClubs => "assets/images/Fanclub1.png";

  String get wishlist => "assets/images/wishlist.png";

  String get fourHrDelivery => "assets/images/4HrDelivery.png";

  String get gift1 => "assets/images/gift1.png";

  String get gift2 => "assets/images/gift2.png";

  String get wallet_Img => "assets/images/wallet_Img.png";

  String get talent_show => "assets/images/Talent_Show.png";

  String get success_bg => "assets/images/Success_Bg.png";

  String get ots => "assets/images/onlinei.png";
}

class _Values {
  String get appName => "Shoppein";

  String get home => "Home";

  String get fanClub => "Fan Club";

  String get categories => "Categories";

  String get whishlist => "Whishlist";

  String get hrDelivery => "4Hr Delivery";

  String get cart => "Cart";

  String get notifications => "Notifications";

  String get profile => "Profile";
}

class AppTheme extends InheritedWidget {
  final _Colors colors = _Colors();
  final _Values values = _Values();
  final _Assets assets = _Assets();
  late final _TextStyles textStyles;

  AppTheme({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    textStyles = _TextStyles(colors);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }
}
