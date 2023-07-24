import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/profile/my_order.dart';
import 'package:mcsofttech/ui/module/profile/my_profile.dart';
import 'package:mcsofttech/ui/module/profile/order_detail.dart';
import 'package:mcsofttech/ui/module/profile/order_tracking.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';

class AccountRoutes {
  AccountRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: EditProfile.routeName, page: () => EditProfile()),
        GetPage(name: MyProfile.routeName, page: () => MyProfile()),
        GetPage(name: MyOrder.routeName, page: () => MyOrder()),
        GetPage(name: OrderDetail.routeName, page: () => OrderDetail()),
        GetPage(name: OrderTracking.routeName, page: () => OrderTracking()),
      ];
}
