class BannerGroup {
  String resourcePath;
  String? bannerType;
  String? link;

  BannerGroup({
    required this.resourcePath,
    this.bannerType,
    this.link,
  });

  factory BannerGroup.fromJson(Map<String, dynamic> map) {
    String imageURL = '';
    if (map['resourcePath'] != null) {
      var parts = map['resourcePath'].split('.com');
      // var prefix = parts[0].trim();
      var image = parts.sublist(1).join('.com').trim();
      print(image);
      imageURL =
          "https://dnpp799vut9mj.cloudfront.net/filters:format(webp)$image";
      print(imageURL);
    }

    return BannerGroup(
      bannerType: map['bannerType'] as String,
      link: map['link'] as String ,
      resourcePath: imageURL,
    );
  }
}
