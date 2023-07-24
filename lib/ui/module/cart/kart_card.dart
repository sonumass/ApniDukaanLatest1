import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import 'package:mcsofttech/notifire/cart_notifire.dart';
import 'package:provider/provider.dart';
import '../../../constants/Constant.dart';
import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../controllers/product/product_Detail_controller.dart';
import '../../../utils/palette.dart';
import '../../base/base_satateless_widget.dart';
import '../../commonwidget/text_style.dart';

class KartCard extends BaseStateLessWidget {
  final Equiry product;
  final wishController = Get.find<TotalVisitorController>();

  KartCard({Key? key, required this.product}) : super(key: key);
  final controller = Get.find<ProductDetailController>();
  final quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    return createCartListItem();
  }

  Widget createCartListItem() {
    quantity.value = product.qunatity;
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                productImage,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productName,
                    price,
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [incrementCount, delete],
            )
          ],
        ),
      ),
    );
  }

  Widget get price {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 10, top: 10),
      child: Row(
        children: [
          Obx(() => Text("\u{20B9} ${product.actualPrice * quantity.value}",
              style: TextStyles.headingTexStyle(
                  fontSize: 12,
                  color: Palette.appColor,
                  fontFamily: "assets/font/Oswald-Regular.ttf"))),
          const SizedBox(
            width: 5,
          ),
          Text("\u{20B9} 0",
              style: TextStyles.headingTexStyle(
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                  color: Palette.kColorRed,
                  fontFamily: "assets/font/Oswald-Regular.ttf"))
        ],
      ),
    );
  }

  Widget get incrementCount {
    return Container(
      width: 130,
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Palette.colorWhite),
          borderRadius: BorderRadius.circular(10),
          color: Palette.kColorExtraLightBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                if (quantity.value <= 1) {
                  Provider.of<CartNotifier>(Get.context!, listen: false)
                      .removeFromCart(product.product_id);
                  controller.removeCart(product);
                  wishController.deleteAction(
                      "Cart", product.product_id, product.id);
                  controller.removeCart(product);
                  return;
                }
                quantity.value -= 1;
                wishController.updateCart(
                    (product.actualPrice * quantity.value),
                    product.id,
                    quantity.value.toString());
              },
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Palette.kColorDarkGrey,
                size: 20,
              )),
          const SizedBox(
            width: 7,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: SizedBox(
              width: 40,
              child: Obx(() => Text(
                    quantity.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyles.headingTexStyle(color: Palette.appColor),
                  )),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                quantity.value += 1;
                wishController.updateCart(
                    (product.actualPrice * quantity.value),
                    product.id,
                    quantity.value.toString());
              },
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyles.headingTexStyle(
                    color: Palette.appColor, fontWeight: FontWeight.w900),
              )),
          const SizedBox(
            width: 7,
          ),
        ],
      ),
    );
  }

  Widget get delete {
    return InkWell(
      onTap: () {
        controller.removeCart(product);
        wishController.deleteAction("Cart", product.product_id, product.id);
        controller.removeCart(product);
        wishController.updateCart(
            (product.actualPrice * quantity.value),
            product.id,
            "0");
      },
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Palette.kColorExtraLightBlack),
            borderRadius: BorderRadius.circular(10),
            color: Palette.kColorWhite),
        child: const Padding(
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Text("Delete",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: Palette.kColorBlack)),
        ),
      ),
    );
  }

  Widget get addAndMinButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
          width: 30,
          child: FloatingActionButton(
            onPressed: () {
              quantity.value += 1;
              Provider.of<CartNotifier>(Get.context!, listen: false)
                  .addCart(product);
              controller.getTotalPrice;
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1), color: Palette.colorWhite),
          child: Obx(() => Padding(
                padding: const EdgeInsets.all(5),
                child: Text(quantity.value.toString(),
                    style: const TextStyle(fontSize: 15.0)),
              )),
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: FloatingActionButton(
            onPressed: () {
              if (quantity.value <= 1) {
                Provider.of<CartNotifier>(Get.context!, listen: false)
                    .removeFromCart(product.product_id);
              }
              quantity.value -= 1;
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.remove, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget get productName {
    return Container(
      width: screenWidget / 2,
      padding: const EdgeInsets.only(right: 10, top: 0),
      child: Text(
        product.productName,
        maxLines: 2,
        softWrap: true,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget get productImage {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 2, top: 8, bottom: 15),
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/png/app_logo.png',
          image: "${Constant.baseUrl}${product.productImg}",
          fit: BoxFit.cover,
          height: 40.0,
        ),
      ),
    );
  }

  Widget get removeFromCart {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          controller.removeCart(product);
        },
        child: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }

  int getPrice(int price, int quantity) {
    int totalPrice = (price * quantity);
    return totalPrice;
  }
}
