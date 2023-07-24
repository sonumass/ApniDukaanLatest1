import 'package:flutter/material.dart';
import 'package:get/get.dart';import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/module/enquiry/widget/enquiry_widget_card.dart';
import '../../../controllers/meridhukaan/enqury_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../dialog/loader.dart';

class EnquiryScreen extends AppPageWithAppBar {
  static const String routeName = "/EnquiryScreen";

  EnquiryScreen({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(
      routeName,
      currentPageTitle: "Enquiry",
    );
  }

  final controller = Get.put(EnquiryController());



  @override
  Widget get body {
    controller.callEnquiryApi();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : controller.enquiryList.isNotEmpty
            ? SingleChildScrollView(child: container)
            : const Center(
                child: Text("No Data founded!"),
              ));
  }

  Widget get container {
    return Container(
      color: MyColors.coloPageBg,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /* const SizedBox(
              height: 10,
            ),
            allNews("News"),*/
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Wrap(
                spacing: 5,
                children: enquiryList,
              ),
            ),
          ],
        ),
      ),
    );
  }


  List<Widget> get enquiryList {
    List<Widget> list = [];
    for (int i = 0; i <= controller.enquiryList.length - 1; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: screenWidget,
            child: EnquiryDataCard(equiryData:controller.enquiryList[i]
            ),
          )));
    }
    return list;
  }



}
