class CategoriesGroup {
  String image;
  String? title;
  String? menuType;
  String? groupName;
  String? groupId;
  String? path;
  dynamic category;

  CategoriesGroup({
    required this.image,
    this.title,
    this.menuType,
    this.groupName,
    this.groupId,
    this.category,
    this.path,
  });

  factory CategoriesGroup.fromJson(Map<String, dynamic> map) {
    String imageURL = '';
    if (map['image'] != null) {
      var parts = map['image'].split('.com');
      // var prefix = parts[0].trim();
      var image = parts.sublist(1).join('.com').trim();
      print(image);
      imageURL =
          "https://dnpp799vut9mj.cloudfront.net/filters:format(webp)$image";
      print(imageURL);
    }

    return CategoriesGroup(
        title: map['title'] as String,
        path: map['path'] as String,
        menuType: map['menuType'] as String,
        groupName: map['groupName'] as String,
        groupId: map['groupId'] as String,
        image: imageURL,
        category: map['category']);
  }
}


