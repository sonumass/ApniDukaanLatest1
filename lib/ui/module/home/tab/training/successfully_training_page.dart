import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/models/training/post_event.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/palette.dart';
import '../../../../../controllers/training/training_controller.dart';
import '../../../../commonwidget/primary_elevated_button.dart';
import '../../../../commonwidget/text_see_more.dart';
import '../../../../commonwidget/text_style.dart';

class SuccessfullyTraining extends BaseStateLessWidget {
   SuccessfullyTraining({Key? key}) : super(key: key);
  final controller = Get.find<TrainingController>();
  @override
  Widget build(BuildContext context) {
    controller.trainingPostEventsList();
    return Obx(() => controller.isPostEventLoader.value?const Loader():SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            aboutHeaderText,
            const SizedBox(
              height: 20,
            ),
            aboutText,
            const SizedBox(
              height: 20,
            ),
            controller.postEventList.isNotEmpty?upcomingTrainingUi:const SizedBox.shrink(),
          ],
        ),
      ),
    ));
  }

  Widget get upcomingTrainingUi {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Wrap(spacing: 5, children: upcomingTraining()));
  }

  List<Widget> upcomingTraining() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.postEventList.length-1; i++) {
      list.add(SizedBox(
        width: screenWidget,
        child: upcomingTrainingCard(controller.postEventList[i]),
      ));
    }
    return list;
  }

  Widget upcomingTrainingCard(PostEvent postEvent) {
    final dateFieldController = TextEditingController();
    dateFieldController.text = postEvent.date;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                  width: screenWidget,
                  placeholder: "assets/png/placeholder.png",
                  image: "${Constant.baseUrl}/${postEvent.images[0].filePath}"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(postEvent.heading,
                style: TextStyles.headingTexStyle(
                  color: MyColors.kColorBlack,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget applyButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("apply_now".tr, () => {}, borderRadius: 40.0),
      ),
    );
  }

  Widget get aboutHeaderText {
    return Text(
      "about_training".tr,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Regular.ttf"),
    );
  }

  Widget get aboutText {
    return ExpandableText(
      "about_training_text".tr,
      trimLines: 2,
    );
  }
}
