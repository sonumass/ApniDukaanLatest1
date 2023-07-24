import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/training_data.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../data/network/apiservices/meridukaan_api_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';
import 'boost_product_controller.dart';

class TotalTrainingController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final productId = "".obs ;
  List<TrainingData> trainingList = [];
  final isLoader = false.obs;
  Razorpay razorpay = Razorpay();
  void callTotalTraining() async {
    isLoader.value = true;
    final response = await apiServices.totalTraining(
      userId: appPreferences.userId,
    );
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      trainingList = response.attendedTrainingList;
    }
  }
  Future<void > createOrderId(amount,String productIdValue) async {
    productId.value=productIdValue;
    showLoader();
    final response = await apiServices.orderCreate(
        paidAmount:amount);
    hideLoader();
    if (response == null) return;
    if (response.status == 200) {
      buyNow(amount,response.data);
    }else{
      Common.showToast(response.message);
    }


  }
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(Get.context!, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    razorpay.clear();
    final controller = Get.put(BoostProductController());
    controller.callProductBoostApi(productId.value,response);
    /*showAlertDialog(Get.context!, "Payment Successful",
        "Payment ID: ${response.paymentId}");*/

  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        Get.context!, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void buyNow(int amount,String orderId) {
    razorpay = Razorpay();
    var options = {
      'key': Constant.razorPayKey,
      'amount': amount,
      'name': 'F2df Private Limited',
      'orderId':'${appPreferences.userId}${Common.currentDateTimeStamp}',
      'description': 'Boost up product',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': appPreferences.mobile,
        'email': appPreferences.email
      },
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }
}
