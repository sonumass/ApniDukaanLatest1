import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/login/before_login.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import 'package:mcsofttech/ui/module/login/otp_page.dart';

class LoginRoutes {
  LoginRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: LoginPage.routeName, page: () => LoginPage()),
        GetPage(name: BeforLoginPage.routeName, page: () => BeforLoginPage()),
        GetPage(name: OtpPage.routeName, page: () => OtpPage()),
        /* GetPage(name: Register.routeName, page: () =>  Register()),
    GetPage(name: Otp.routeName, page: () =>  Otp()),*/
      ];
}
