import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/addsellrent/rent_sell.dart';

class RentSellRoutes {
  RentSellRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: RentSell.routeName, page: () => RentSell()),
      ];
}
