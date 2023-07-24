import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/category/browse_category.dart';
import '../../ui/module/category/subcategory/browse_all_sub_category_page.dart';
import '../../ui/module/category/subcategory/subcategory_page.dart';

class CategoryRoutes {
  CategoryRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: BrowseCategory.routeName, page: () => BrowseCategory()),
        GetPage(name: SubCagetoryPage.routeName, page: () => SubCagetoryPage()),
        GetPage(
            name: BrowseSubCategory.routeName, page: () => BrowseSubCategory()),
      ];
}
