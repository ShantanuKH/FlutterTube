
class ShortVideoModel {
  final String caption;
  final String userId;
  final String shortVideo;
  final String datePublished;
  ShortVideoModel({
    required this.caption,
    required this.userId,
    required this.shortVideo,
    required this.datePublished,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'caption': caption,
      'userId': userId,
      'shortVideo': shortVideo,
      'datePublished': datePublished,
    };
  }

  factory ShortVideoModel.fromMap(Map<String, dynamic> map) {
    return ShortVideoModel(
      caption: map['caption'] as String,
      userId: map['userId'] as String,
      shortVideo: map['shortVideo'] as String,
      datePublished: map['datePublished'] as String,
    );
  }

 
}
