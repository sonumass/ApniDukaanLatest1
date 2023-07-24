import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/product/product_detail.dart';
import 'package:mcsofttech/ui/module/product/product_list.dart';
import 'package:mcsofttech/ui/module/product/product_similler_detail.dart';

import '../../ui/module/product/product_search_page.dart';

class ProductRoutes {
  ProductRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: ProductDetail.routeName, page: () => ProductDetail()),
        GetPage(name: ProductList.routeName, page: () => ProductList()),
        GetPage(
            name: ProductSearchList.routeName, page: () => ProductSearchList()),
        GetPage(
            name: ProductSimilarDetail.routeName,
            page: () => ProductSimilarDetail()),
      ];
}
