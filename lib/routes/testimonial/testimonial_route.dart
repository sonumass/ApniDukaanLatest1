import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../ui/module/testimonial/testimonial_details.dart';
import '../../ui/module/testimonial/testimonial_screen.dart';

class TestimonialRoutes {
  TestimonialRoutes._();

  static List<GetPage> get routes => [
        GetPage(
            name: TestimonialScreen.routeName, page: () => TestimonialScreen()),
        GetPage(
            name: TestimonialDetails.routeName, page: () => TestimonialDetails()),
      ];
}
