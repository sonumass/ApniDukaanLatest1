import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/common_model_response.dart';
import 'package:mcsofttech/models/order/orderInputModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../constants/Constant.dart';
import '../../../models/category/product_by_cat_id/product_by_cat_id.dart';
import '../../../models/common_message_model.dart';
import '../../../models/meridukaan/Enquiry_model_data.dart';
import '../../../models/meridukaan/create/check_company_link_model.dart';
import '../../../models/meridukaan/create/create_my_shop_input.dart';
import '../../../models/meridukaan/meri_dukaan_model.dart';
import '../../../models/meridukaan/userdashboard/AddUserData.dart';
import '../../../models/meridukaan/userdashboard/TrainingModel.dart';
import '../../../models/meridukaan/userdashboard/userDashboard.dart';
import '../../../models/meridukaan/userdashboard/userDynamicDashboard.dart';
import '../../../models/meridukaan/userdashboard/user_dashboard_card_data_model.dart';
import '../dio_client.dart';

class MeriDukaanApiServices extends DioClient {
  final client = DioClient.client;

  Future<MeriDukaanModel?> meriDukaanHomeApi({userId}) async {
    var inputData = {"id": userId};
    debugPrint('inputData: $inputData');
    MeriDukaanModel? meriDukaanModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/myDukan/getDukanDetail",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        meriDukaanModel = MeriDukaanModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return meriDukaanModel;
  }

  Future<UserDashboardCardDataModel?> totalVisitor(
      {userId, dataType, productId}) async {
    var inputData = {"userId": userId, "productType": dataType};
    debugPrint('inputData: $inputData');
    UserDashboardCardDataModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getInterestListByUser",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = UserDashboardCardDataModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }
  Future<CommonResponseModel?> orderCreate(
      {paidAmount,}) async {
    var inputData = {"paidAmount": paidAmount,};
    debugPrint('inputData: $inputData');
    CommonResponseModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/getOrderId",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<UserDashboardCardDataModel?> deleteData(
      {userId, dataType, productId, id}) async {
    var inputData = {
      "userId": userId,
      "productType": dataType,
      "productId": productId,
      "id": id
    };
    debugPrint('inputData: $inputData');
    UserDashboardCardDataModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/deleteInterestListByUser",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = UserDashboardCardDataModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<CommonResponseModel?> updateCart(
      {userId, price, productId, qunatity}) async {
    var inputData = {
      "user_id": userId,
      "price": price,
      "id": productId,
      "qunatity": qunatity
    };
    debugPrint('inputData: $inputData');
    CommonResponseModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/updateInterestListByUser",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<TrainingModel?> totalTraining({userId}) async {
    var inputData = {
      "userId": userId,
    };
    debugPrint('inputData: $inputData');
    TrainingModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getTrainingAttended",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = TrainingModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<CommonResponseModel?> addUserActionData(
      String productImg,
      String email,
      int id,
      String mobile,
      String price,
      String productName,
      int product_id,
      int product_user_id,
      String status,
      String subCategory,
      String type,
      String updateDate,
      String userName,
      int user_id,
      int qunatity) async {
    String addUserActionData = jsonEncode(AddUserActionData(
        productImg: productImg,
        email: email,
        id: id,
        mobile: mobile,
        price: price,
        productName: productName,
        product_id: product_id,
        product_user_id: product_user_id,
        status: status,
        subCategory: subCategory,
        type: type,
        updateDate: updateDate,
        userName: userName,
        user_id: user_id,
        qunatity: qunatity));
    debugPrint('inputData: $addUserActionData}');
    CommonResponseModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/addInterest",
        data: addUserActionData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<CheckCompanyLinkModel?> checkApi({url}) async {
    var inputData = {"mereDukanLink": url};
    debugPrint('inputData: $inputData');
    CheckCompanyLinkModel? commonResponseModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/myDukan/checkDukanLink",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CheckCompanyLinkModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonResponseModel;
  }

  Future<CheckCompanyLinkModel?> createShopApi(
      aboutUs,
      address,
      dukanLink,
      email,
      fbLink,
      gitHubLink,
      instaLink,
      linkdinLink,
      name,
      phone,
      whatsAppNumber,
      natureOfBuss,
      status,
      tagLine,
      twitterLink,
      userId,
      id,
      youTubeLink,
      yrsOfEst,
      logo) async {
    String inputData = jsonEncode(CreateMyShopInput(
        aboutUs,
        address,
        dukanLink,
        email,
        fbLink,
        gitHubLink,
        instaLink,
        linkdinLink,
        name,
        phone,
        whatsAppNumber,
        natureOfBuss,
        status,
        tagLine,
        twitterLink,
        userId,
        id,
        youTubeLink,
        yrsOfEst,
        logo));
    debugPrint('inputData: $inputData');
    CheckCompanyLinkModel? commonResponseModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/myDukan/addMyDukan",
        data: inputData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CheckCompanyLinkModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonResponseModel;
  }

  Future<ProductByCatIdModel?> productListForApi({userId}) async {
    var inputData = {"userId": userId};
    ProductByCatIdModel? productByCatIdModel;
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}//product/getProductsByUser",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }

  Future<CommonResponseModel?> uploadImage(
      {fileContentBase64, fileName, userId}) async {
    late CommonResponseModel? commonResponseModel;
    var inputData = {
      "fileContentBase64": fileContentBase64,
      "fileName": fileName,
      "userId": userId
    };
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/uploadImage",
        data: inputData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return commonResponseModel;
  }

  Future<UserDynamicDashboard?> userDashboard({userId}) async {
    var inputData = {"userId": userId};
    debugPrint('inputData: $inputData');
    UserDynamicDashboard? userDashboard;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/dashboard",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        userDashboard = UserDynamicDashboard.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userDashboard;
  }

  Future<CommonModelResponse?> deleteProductApi({productId, action}) async {
    var inputData = {"p_id": productId, "action": action};
    debugPrint('inputData: $inputData');
    CommonModelResponse? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/editProduct/",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = CommonModelResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }
  Future<void> createOrderId(String userId,int amount) async {



  }
  Future<CommonModelResponse?> saveTransaction(
      {cartId,
      code,
      error,
      message,
      orderId,
      paidAmount,
      paymentId,
      signature,
      userId,
      status}) async {
    String orderInputModel = jsonEncode(OrderInputModel(
        cartId: cartId,
        code: code,
        error: error,
        message: message,
        orderId: orderId,
        paidAmount: paidAmount,
        paymentId: paymentId,
        signature: signature,
        status: status ? "Success" : "Failed",
        userId: userId));
    debugPrint('inputData: $orderInputModel');
    CommonModelResponse? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/saveTransaction",
        data: orderInputModel,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = CommonModelResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<CommonResponseModel?> boostApi(
      String productId, PaymentSuccessResponse response,String userId) async {
    late CommonResponseModel? commonResponseModel;
    var inputData = {
      "p_id": productId,
      "signature": response.signature,
      "orderId": response.orderId,
      "paymentId": response.paymentId,
      "status": "Success",
      "userId": userId
    };
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/boostProduct",
        data: inputData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonResponseModel;
  }

  Future<EnquiryModelData?> enquiryApi({productType, userId}) async {
    late EnquiryModelData? enquiryModelData;
    var inputData = {"userId": userId, "productType": productType};
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getInterestListByType",
        data: inputData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        enquiryModelData = EnquiryModelData.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return enquiryModelData;
  }
}
