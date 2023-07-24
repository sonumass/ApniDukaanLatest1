// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get bannerUnit => 'ca-app-pub-9884736783340682/5613858527';
  //static String get bannerUnit => 'ca-app-pub-9884736783340682/4450162774';

  static initialization() {
    MobileAds.instance.initialize();
  }

  static BannerAd getBannerAd() {
    BannerAd bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('Banner loaded');
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            ad.dispose();
            debugPrint('Ad failed to load: $error');
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (ad) {
            debugPrint('Ad opened.');
          },
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (ad) {
            debugPrint('Ad closed.');
          },
          // Called when an impression occurs on the ad.
          onAdImpression: (ad) {
            debugPrint('Ad impression.');
          },
        ),
        request: const AdRequest());
    return bannerAd;
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2745352869491766/9538273271';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2745352869491766/3331310114';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

/* static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }*/

/*static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8673189370';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/7552160883';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }*/
}
