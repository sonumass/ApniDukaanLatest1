import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/cart/cart_list_page.dart';
import 'package:mcsofttech/ui/module/cart/delivery_page.dart';

import '../../ui/module/meridukaan/internal_page/wish_list_page.dart';

class CartRoutes {
  CartRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: CartListPage.routeName, page: () => CartListPage()),
        GetPage(name: WishListPage.routeName, page: () => WishListPage()),
        GetPage(name: DeliveryPage.routeName, page: () => DeliveryPage()),
      ];
}
