part of "my_theme.dart";

double get size_0 => getSize(0);

double get size_1 => getSize(1);

double get size_2 => getSize(2);

double get size_3 => getSize(3);

double get size_4 => getSize(4);

double get size_5 => getSize(5);

double get size_6 => getSize(6);

double get size_8 => getSize(8);

double get size_9 => getSize(9);

double get size_10 => getSize(10);

double get size_11 => getSize(11);

double get size_12 => getSize(12);

double get size_13 => getSize(13);

double get size_14 => getSize(14);

double get size_15 => getSize(15);

double get size_16 => getSize(16);

double get size_18 => getSize(18);

double get size_20 => getSize(20);

double get size_22 => getSize(22);

double get size_24 => getSize(24);

double get size_25 => getSize(25);

double get size_28 => getSize(28);

double get size_30 => getSize(30);

double get size_32 => getSize(32);

double get size_36 => getSize(36);

double get size_38 => getSize(38);

double get size_40 => getSize(40);

double get size_44 => getSize(44);

double get size_48 => getSize(48);

double get size_50 => getSize(50);

double get size_52 => getSize(52);

double get size_54 => getSize(54);

double get size_56 => getSize(56);

double get size_60 => getSize(60);

double get size_64 => getSize(64);

double get size_65 => getSize(64);

double get size_70 => getSize(70);

double get size_76 => getSize(76);

double get size_80 => getSize(80);

double get size_90 => getSize(90);

double get size_96 => getSize(96);

double get size_100 => getSize(100);

double get size_110 => getSize(110);

double get size_120 => getSize(120);

double get size_130 => getSize(130);

double get size_140 => getSize(140);

double get size_145 => getSize(145);

double get size_150 => getSize(150);

double get size_160 => getSize(160);

double get size_180 => getSize(180);

double get size_200 => getSize(200);

double get size_220 => getSize(220);

double get size_250 => getSize(250);

double get size_300 => getSize(300);

double get size_360 => getSize(360);

double get size_500 => getSize(500);

getSize(size, {bool withHeight = true}) {
  if (withHeight)
    return _getHeightSize(size);
  else
    return _getWidthSize(size);
}

double _getHeightSize(dynamic value) {
  double unitHeightValue =
      (window.physicalSize.height / window.devicePixelRatio) * 0.0013;
  return unitHeightValue * value;
}

double _getWidthSize(dynamic value) {
  double unitHeightValue =
      (window.physicalSize.width / window.devicePixelRatio) * 0.0013;
  return unitHeightValue * value;
}
