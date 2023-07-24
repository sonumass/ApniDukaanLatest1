import 'package:flutter/material.dart';

import '../../../../models/meridukaan/meri_dukaan_model.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';

class GalleryStatefulWidget extends StatefulWidget {
  final MeriDukaanModel? meriDukaanModel;

  const GalleryStatefulWidget({Key? key, required this.meriDukaanModel})
      : super(key: key);

  @override
  State<GalleryStatefulWidget> createState() => _GalleryStatefulWidgetState();
}

class _GalleryStatefulWidgetState extends State<GalleryStatefulWidget> {
  double width = 0.0;
  List<String> imageList = [
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602002967662.jpg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732404.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602079086521.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732398.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732405.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602079086522.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732399.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732406.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602079086523.png",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732400.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732407.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602079086524.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732401.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078765903.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732402.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078732403.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602078782237.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602079124078.jpeg",
    "https://gyanhouse.com/new-f2df/mydukan/assets/images/1602079124080.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: double.maxFinite,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
            height: double.maxFinite,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
              children: [
                aboutUsText,
                const SizedBox(
                  width: 140,
                  child: Divider(color: Colors.red, height: 20.0, thickness: 5),
                ),
                widget.meriDukaanModel?.gallaryList.isNotEmpty ?? false
                    ? Wrap(
                        spacing: 5,
                        children: productList(
                            widget.meriDukaanModel?.gallaryList ?? []),
                      )
                    : Center(
                        child: Text(
                          "Data not found!",
                          style: TextStyles.headingTexStyle(color: Colors.red),
                        ),
                      ),
              ],
            ))),
      ),
    );
  }

  Widget get aboutUsText {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          "Gallery",
          style: TextStyles.headingTexStyle(color: Colors.green),
        ),
      ),
    );
  }

  List<Widget> productList(List<String> gallaryList) {
    List<Widget> list = [];
    for (int i = 0; i <= gallaryList.length; i++) {
      list.add(SizedBox(
        width: width / 3.5,
        child: productCard(i),
      ));
    }
    return list;
  }

  Widget productCard(int index) {
    return productImage(index);
  }

  Widget productImage(int index) {
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (_) => ImageDialog(
                  imageUrl: imageList[index],
                ));
      },
      child: FadeInImage.assetNetwork(
          placeholder: "assets/png/placeholder.png", image: imageList[index]),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(imageUrl),
        )),
      ),
    );
  }
}
