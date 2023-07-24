import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../models/meridukaan/meri_dukaan_model.dart';
import '../../../../utils/palette.dart';

class MeriDukaanHome extends StatefulWidget {
  final MeriDukaanModel? meriDukaanModel;

  MeriDukaanHome({Key? key, required this.meriDukaanModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MeriDukaanHomeState();
  }
}

class _MeriDukaanHomeState extends State<MeriDukaanHome> {
  final initialSelection = "+91".obs;
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.meriDukaanModel != null
        ? Container(
            height: double.maxFinite,
            color: Colors.green,
            child: widget.meriDukaanModel != null
                ? SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            halfDetail,
                            secondHalf,
                          ],
                        )))
                : const SizedBox.shrink(),
          )
        : const SizedBox.shrink();
  }

  Widget get halfDetail {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          view,
          dukaanImage,
          dukaanName,
          const SizedBox(
            width: 140,
            child: Divider(color: Colors.red, height: 20.0, thickness: 5),
          ),
          dukaanDescription,
          iconRow,
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget get view {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Views: ${widget.meriDukaanModel?.reviewCount})",
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget get dukaanImage {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.green),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: widget.meriDukaanModel?.dukanDetails?.logo != null
              ? FadeInImage.assetNetwork(
                  width: 100,
                  height: 100,
                  placeholder: "assets/png/placeholder.png",
                  image:
                      "${Constant.baseUrl}${widget.meriDukaanModel?.dukanDetails?.logo ?? ""}")
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget get dukaanName {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        widget.meriDukaanModel?.dukanDetails?.name ?? "",
        style: TextStyles.headingTexStyle(color: Palette.appColor),
      ),
    );
  }

  Widget get dukaanDescription {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        widget.meriDukaanModel?.dukanDetails?.tagLine ?? "",
        style: TextStyles.headingTexStyle(color: Palette.appColor),
      ),
    );
  }

  Widget get iconRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        callButton,
        whatsAppButton,
        directionButton,
        mailButton,
      ],
    );
  }

  _callNumber() async {
    final number = widget.meriDukaanModel?.dukanDetails?.mobile ??
        '8527673533'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    if (res ?? false) {
      debugPrint("call");
    }
  }

  Widget get callButton {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          IconButton(
            color: Colors.green,
            icon: const Icon(
              Icons.call,
              color: Colors.green,
            ),
            onPressed: () {
              _callNumber();
            },
          ),
          Text(
            "Call me",
            style: TextStyles.labelTextStyle(color: Palette.appColor),
          )
        ],
      ),
    );
  }

  Widget get whatsAppButton {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            IconButton(
              iconSize: 30,
              disabledColor: Colors.green,
              focusColor: Colors.green,
              highlightColor: Colors.green,
              splashColor: Colors.green,
              color: Colors.green,
              icon: const Icon(
                Icons.whatsapp,
                color: Colors.green,
              ),
              onPressed: () {
                share();
              },
            ),
            Text(
              "WhatsApp",
              style: TextStyles.labelTextStyle(color: Palette.appColor),
            )
          ],
        ));
  }

  void shareWhatsAPP(String phoneNumber) async {
    if (phoneNumber.isNotEmpty) {
      Common.showToast("Please enter phone number");
      return;
    }
    await launchUrl(Uri.parse(
        "whatsapp://send?phone=$phoneNumber&text=${widget.meriDukaanModel?.dukanDetails?.dukanLink}"));
  }

  Widget get directionButton {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          IconButton(
            iconSize: 30,
            disabledColor: Colors.green,
            focusColor: Colors.green,
            highlightColor: Colors.green,
            splashColor: Colors.green,
            color: Colors.green,
            icon: const Icon(
              Icons.location_on,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
          Text(
            "Direction",
            style: TextStyles.labelTextStyle(color: Palette.appColor),
          )
        ],
      ),
    );
  }

  Widget get mailButton {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            IconButton(
              iconSize: 30,
              disabledColor: Colors.green,
              focusColor: Colors.green,
              highlightColor: Colors.green,
              splashColor: Colors.green,
              color: Colors.green,
              icon: const Icon(
                Icons.mail,
                color: Colors.green,
              ),
              onPressed: () {
                share();
              },
            ),
            Text(
              "Mail",
              style: TextStyles.labelTextStyle(color: Palette.appColor),
            )
          ],
        ));
  }

  share() {
    final RenderBox? box = Get.context!.findRenderObject() as RenderBox?;
    Share.share(widget.meriDukaanModel?.dukanDetails?.dukanLink ?? "",
        subject: widget.meriDukaanModel?.dukanDetails?.name ?? "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Widget get secondHalf {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          addressWidget,
          emailWidget,
          contactWidget,
          phoneAndWhatsApp,
        ],
      ),
    );
  }

  Widget get addressWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () {},
          color: Colors.white,
          textColor: Colors.green,
          padding: const EdgeInsets.all(2),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.location_on_rounded,
          ),
        ),
        Expanded(
            child: Text(
          widget.meriDukaanModel?.dukanDetails?.address ?? "",
          style: TextStyles.labelTextStyle(color: Palette.kColorWhite),
        ))
      ],
    );
  }

  Widget get emailWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () {
            share();
          },
          color: Colors.white,
          textColor: Colors.green,
          padding: const EdgeInsets.all(2),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.email,
          ),
        ),
        Expanded(
            child: Text(
          widget.meriDukaanModel?.dukanDetails?.email ?? "",
          style: TextStyles.labelTextStyle(color: Palette.kColorWhite),
        ))
      ],
    );
  }

  Widget get contactWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () {},
          color: Colors.white,
          textColor: Colors.green,
          padding: const EdgeInsets.all(2),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.call,
          ),
        ),
        Expanded(
            child: Text(
          widget.meriDukaanModel?.dukanDetails?.mobile ?? "+91-9138111860",
          style: TextStyles.labelTextStyle(color: Palette.kColorWhite),
        ))
      ],
    );
  }

  Widget get phoneAndWhatsApp {
    return Column(
      children: [countryCodeAndMobile, whatsAppShareButton],
    );
  }

  Widget get countryCodeAndMobile {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CountryListPick(
              theme: CountryTheme(
                isShowFlag: true,
                isShowCode: true,
                isDownIcon: true,
                isShowTitle: false,
              ),
              // Set default value
              initialSelection: initialSelection.value,
              // or
              // initialSelection: 'US'
              onChanged: (CountryCode? code) {
                debugPrint(code!.code);
                initialSelection.value = code.code!;
              },
              // Whether to allow the widget to set a custom UI overlay
              useUiOverlay: true,
              // Whether the country list should be wrapped in a SafeArea
              useSafeArea: false),
          Expanded(
            child: TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your mobile',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get whatsAppShareButton {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.maxFinite,
        height: 45,
        child: ElevatedButton.icon(
          onPressed: () {
            shareWhatsAPP(phoneNumberController.text);
          },
          icon: const Icon(
            // <-- Icon
            Icons.whatsapp,
          ),
          label: const Text('Share on whatsApp '), // <-- Text
        ),
      ),
    );
  }
}
