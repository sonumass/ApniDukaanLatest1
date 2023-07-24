import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/meridukaan/internal_page/total_training_attanded.dart';
import 'package:mcsofttech/ui/module/meridukaan/my_shop_order.dart';
import 'package:mcsofttech/ui/module/meridukaan/shop_order_detail.dart';
import '../../ui/module/enquiry/enquiry_screen.dart';
import '../../ui/module/meridukaan/internal_page/boost_your_product.dart';
import '../../ui/module/meridukaan/internal_page/total_visiter.dart';
class MeriDukaanRoutes {
  MeriDukaanRoutes._();
  static List<GetPage> get routes => [
        GetPage(name: TotalVisitor.routeName, page: () => TotalVisitor()),
        GetPage(name: TotalTraining.routeName, page: () => TotalTraining()),
        GetPage(name: BoostYourProduct.routeName, page: () => BoostYourProduct()),
        GetPage(name: EnquiryScreen.routeName, page: () => EnquiryScreen()),
    GetPage(name: MyShopOrder.routeName, page: () => MyShopOrder()),
    GetPage(name: ShopOrderDetail.routeName, page: () => ShopOrderDetail()),
      ];
}
