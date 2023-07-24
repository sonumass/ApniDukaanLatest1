import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import '../../data/network/apiservices/news_api_service.dart';
import '../../models/newandvideo/BannerList.dart';
import '../../models/newandvideo/News.dart';
import '../../utils/common_util.dart';

class NewsController extends BaseController {
  final apiServices = Get.put(NewsApiServices());
  final isLoader = false.obs;
  final RxList<News> newsList = <News>[].obs;
  int pageCount = 1;
  final size = 10;
  final List<BannerList> bannerList = [];

  void callNewsApi({pageNo, size, String type = "News"}) async {
    isLoader.value = true;
    try {
      final response = await apiServices.newsApi(pageNo, 10, type);

      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        if (response.news.isNotEmpty) {
          newsList.addAll(response.news);
        }
        if (response.bannerList.isNotEmpty && pageNo == 1) {
          bannerList.addAll(response.bannerList);
        }
        pageCount += 1;
      }
    } catch (e) {
      Common.showToast("Server error");
      debugPrint(e.toString());
    }
  }

  void callScrollNewsApi({pageNo, size, String type = "News"}) async {
    showLoader();
    try {
      final response = await apiServices.newsApi(pageNo, 10, type);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        if (response.news.isNotEmpty) {
          newsList.addAll(response.news);
        }
        if (response.bannerList.isNotEmpty && pageNo == 1) {
          bannerList.addAll(response.bannerList);
        }
        pageCount += 1;
      }
    } catch (e) {
      Common.showToast("Server error");
      debugPrint(e.toString());
    }
  }

  void callVideoApi({pageNo, size, String type = "Video"}) async {
    isLoader.value = true;
    try {
      final response = await apiServices.videoApi(pageNo, 10, type);

      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        if (response.news.isNotEmpty) {
          newsList.addAll(response.news);
        }
        if (response.bannerList.isNotEmpty && pageNo == 1) {
          bannerList.addAll(response.bannerList);
        }
        pageCount += 1;
      }
    } catch (e) {
      Common.showToast("Server error");
      debugPrint(e.toString());
    }
  }

  void callSearchVideoApi({pageNo, size, String type = "Video"}) async {
    showLoader();
    try {
      final response = await apiServices.videoApi(pageNo, 10, type);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        if (response.news.isNotEmpty) {
          newsList.addAll(response.news);
        }
        if (response.bannerList.isNotEmpty && pageNo == 1) {
          bannerList.addAll(response.bannerList);
        }
        pageCount += 1;
      }
    } catch (e) {
      Common.showToast("Server error");
      debugPrint(e.toString());
    }
  }
}
