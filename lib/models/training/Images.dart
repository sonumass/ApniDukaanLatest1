class Images {
  Images({
      required this.id,
      required this.originalFileName,
      required this.fileName,
      required this.filePath,
      required this.fileSize,
      required this.thumbnailPath,
      required this.newsId,
      required this.eventsId,});

  Images.fromJson(dynamic json) {
    id = json['id']??0;
    originalFileName = json['originalFileName']??"";
    fileName = json['fileName']??"";
    filePath = json['filePath']??"";
    fileSize = json['fileSize']??"";
    thumbnailPath = json['thumbnailPath']??"";
    newsId = json['newsId']??0;
    eventsId = json['eventsId']??0;
  }
  int id=0;
  String originalFileName="";
  String fileName="";
  String filePath="";
  String fileSize="";
  String thumbnailPath="";
  int newsId=0;
  int eventsId=0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['originalFileName'] = originalFileName;
    map['fileName'] = fileName;
    map['filePath'] = filePath;
    map['fileSize'] = fileSize;
    map['thumbnailPath'] = thumbnailPath;
    map['newsId'] = newsId;
    map['eventsId'] = eventsId;
    return map;
  }

}