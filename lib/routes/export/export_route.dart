import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/meridukaan/meri_dukaan.dart';

import '../../ui/module/export/buyer_availability.dart';
import '../../ui/module/home/drawar/web_view.dart';
import '../../ui/module/home/home.dart';
import '../../ui/module/home/tab/banking_screen.dart';
import '../../ui/module/home/tab/prime_screen.dart';
import '../../ui/module/home/tab/training_screen.dart';
import '../../ui/module/meridukaan/create_shop.dart';
import '../../ui/module/meridukaan/meri_dekaan_dashboard.dart';
import '../../ui/module/meridukaan/my_product.dart';
import '../../ui/module/news_and_video/news_and_video.dart';
import '../../ui/module/thankyou/thank_you.dart';
import '../../ui/module/videos/VideoNewsDetail.dart';

class ExportRoutes {
  ExportRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: BuyerAvailabilityPage.routeName, page: () => BuyerAvailabilityPage()),

      ];
}
