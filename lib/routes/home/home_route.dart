import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/meridukaan/meri_dukaan.dart';

import '../../ui/module/home/drawar/web_view.dart';
import '../../ui/module/home/drawar/web_view_term_and_condition.dart';
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

class HomeRoutes {
  HomeRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: Home.routeName, page: () => Home()),
        GetPage(name: MeriDukaan.routeName, page: () => MeriDukaan()),
        GetPage(name: NavigationWebView.routeName, page: () => NavigationWebView()),
    GetPage(name: TermAndConditionWebView.routeName, page: () => TermAndConditionWebView()),
        GetPage(name: NewsAndVideo.routeName, page: () => NewsAndVideo()),
        GetPage(name: MyStatefulWidget.routeName, page: () => MyStatefulWidget()),
        GetPage(name: CreateShop.routeName, page: () => CreateShop()),
        GetPage(name: MyProductPage.routeName, page: () => MyProductPage()),
        GetPage(name: BankingPage.routeName, page: () => BankingPage()),
        GetPage(name: TrainingPage.routeName, page: () => TrainingPage()),
        GetPage(name: PrimePage.routeName, page: () => PrimePage()),
        GetPage(name: ThankYou.routeName, page: () => ThankYou()),
        GetPage(name: VideoNewsDetail.routeName, page: () => VideoNewsDetail()),
      ];
}
