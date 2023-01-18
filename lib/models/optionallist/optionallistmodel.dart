
class OptionalList {

  List<Option1>? option1;

  OptionalList({option1});

  OptionalList.fromJson(Map<String, dynamic> json) {
    if (json['option1'] != null) {
      option1 = <Option1>[];
      json['option1'].forEach((v) {
        option1!.add(Option1.fromJson(v));
      });
    }
  }
}

class Option1 {
  String? sku;
  int? inventory;
  String? attributeStyle;
  String? label;
  String? attributeLabel;
  List<Media>? media;
  List<Level2>? level2;

  Option1(
      {sku,
      inventory,
      attributeStyle,
      label,
      attributeLabel,
      media,
      level2});

  Option1.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    inventory = json['inventory'];
    attributeStyle = json['attributeStyle'];
    label = json['label'];
    attributeLabel = json['attributeLabel'];
    if (json['media'] != null) {
      media = <Media>[];
      String? type =  json['media']['type'];
      String? resourcePath =  json['media']['resourcePath'];
      String? sId =  json['media']['_id'];
      media!.add(Media(type: type,resourcePath: resourcePath,sId: sId));
    }
    if (json['level2'] != null) {
      level2 = <Level2>[];
      json['level2'].forEach((v) {
        level2!.add(Level2.fromJson(v));
      });
    }
  }
}

class Media {
  String? type;
  String? resourcePath;
  String? sId;

  Media({this.type, this.resourcePath, this.sId});

  Media.fromJson(Map<String, String> json) {
    type = json['type'];
    resourcePath = json['resourcePath'];
    sId = json['_id'];
  }


}

class Level2 {
  String? sku;
  int? inventory;
  String? attributeStyle;
  String? name;
  String? label;
  String? attributeValueId;
  String? attributeLabel;

  Level2({sku,
      inventory,
      attributeStyle,
      name,
      label,
      attributeValueId,
      attributeLabel,
      });

  Level2.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    inventory = json['inventory'];
    attributeStyle = json['attributeStyle'];
    name = json['name'];
    label = json['label'];
    attributeValueId = json['attributeValueId'];
    attributeLabel = json['attributeLabel'];
  }
}


