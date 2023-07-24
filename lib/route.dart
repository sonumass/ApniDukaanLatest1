import 'package:mcsofttech/routes/account/account_route.dart';
import 'package:mcsofttech/routes/cart/cart_route.dart';
import 'package:mcsofttech/routes/category/category_route.dart';
import 'package:mcsofttech/routes/export/export_route.dart';
import 'package:mcsofttech/routes/home/home_route.dart';
import 'package:mcsofttech/routes/login/login.dart';
import 'package:mcsofttech/routes/meridukaan/meri_dukaan_route.dart';
import 'package:mcsofttech/routes/newandvideo/news_and_video_route.dart';
import 'package:mcsofttech/routes/notification/notification_route.dart';
import 'package:mcsofttech/routes/product/product_route.dart';
import 'package:mcsofttech/routes/rent_sell/rent_sell_route.dart';
import 'package:mcsofttech/routes/splash_routes.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/routes/testimonial/testimonial_route.dart';

class Routes {
  Routes._();

  static List<GetPage> get() {
    final moduleRoutes = <GetPage>[];
    moduleRoutes.addAll(SplashScreenRoutes.routes);
    moduleRoutes.addAll(LoginRoutes.routes);
    moduleRoutes.addAll(HomeRoutes.routes);
    moduleRoutes.addAll(AccountRoutes.routes);
    moduleRoutes.addAll(CategoryRoutes.routes);
    moduleRoutes.addAll(ProductRoutes.routes);
    moduleRoutes.addAll(RentSellRoutes.routes);
    moduleRoutes.addAll(CartRoutes.routes);
    moduleRoutes.addAll(NotificationRoutes.routes);
    moduleRoutes.addAll(MeriDukaanRoutes.routes);
    moduleRoutes.addAll(NewsVideoRoutes.routes);
    moduleRoutes.addAll(TestimonialRoutes.routes);
    moduleRoutes.addAll(ExportRoutes.routes);
    return moduleRoutes;
  }
}
