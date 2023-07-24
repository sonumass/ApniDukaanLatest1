import 'package:flutter/cupertino.dart';
import 'package:mcsofttech/ui/module/videos/video_player_screen.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';

class VideoNewsDetail extends AppPageWithAppBar {
  static const String routeName = "/videoDetailScreen";

  VideoNewsDetail({super.key});

  static Future<bool?> start<bool>(String title,String videoId) {
    return navigateTo<bool>(routeName,
        currentPageTitle: "F2DF TV", arguments: {"videoId": videoId});
  }

  @override
  Widget get body {
    return VideoPlayerScreen(videoId:arguments['videoId']);
  }
}
