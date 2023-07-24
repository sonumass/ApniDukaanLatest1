import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/meridukaan/tab/enquiry_meri_dukaan.dart';
import 'package:mcsofttech/ui/module/meridukaan/tab/feedback_meri_dukaan.dart';
import 'package:mcsofttech/ui/module/meridukaan/tab/gallery_meri_dukaan.dart';
import 'package:mcsofttech/ui/module/meridukaan/tab/meri_dukaan_about_us.dart';
import 'package:mcsofttech/ui/module/meridukaan/tab/meri_dukaan_home.dart';
import 'package:mcsofttech/ui/module/meridukaan/tab/product_of_meri_dukaan.dart';
import '../../../controllers/meridhukaan/meri_dukaan_controller.dart';
import '../../../services/navigator.dart';

class MyStatefulWidget extends StatefulWidget {
  static const String routeName = "/meriDukaanDashboard";

  const MyStatefulWidget({super.key});

  static Future<bool?> start<bool>(String title) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final controller = Get.put(MeriDukaanController());
  final List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('meri_dukaan'.tr),
      ),
      body: Obx(
        () => controller.isLoader.value
            ? const Loader()
            : widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Colors.green, size: 20),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory_2, color: Colors.green, size: 17),
            label: 'product'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.question_answer,
                color: Colors.green, size: 20),
            label: 'enquiry'.tr,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.photo_album, color: Colors.green, size: 20),
            label: 'Gallery',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.green, size: 20),
            label: 'Feedback',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.contact_page, color: Colors.green, size: 20),
            label: 'AboutUs',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> get widgetOptions {
    _widgetOptions
        .add(MeriDukaanHome(meriDukaanModel: controller.meriDukaanModel));
    _widgetOptions.add(const ProductStatefulWidget());
    _widgetOptions.add(const EnquiryStatefulWidget());
    _widgetOptions.add(
        GalleryStatefulWidget(meriDukaanModel: controller.meriDukaanModel));
    _widgetOptions.add(const FeedbackStatefulWidget());
    _widgetOptions.add(
        AboutUsStatefulWidget(meriDukaanModel: controller.meriDukaanModel));
    return _widgetOptions;
  }
}
