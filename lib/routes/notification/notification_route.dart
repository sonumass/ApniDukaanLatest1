import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/notfication/notifation_page.dart';

class NotificationRoutes {
  NotificationRoutes._();

  static List<GetPage> get routes => [
        GetPage(
            name: NotificationPage.routeName, page: () => NotificationPage()),
      ];
}
