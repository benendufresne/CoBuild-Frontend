/// Model class to hanlde Facebook response :- While selecting login via Facebook(Currently not used)
class FacebookResponseModel {
  String? email;
  String? id;
  Picture? picture;
  String? name;

  FacebookResponseModel({this.email, this.id, this.picture, this.name});

  FacebookResponseModel.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    id = json['id'];
    picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['id'] = id;
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    data['name'] = name;
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? isSilhouette;
  int? height;
  String? url;
  int? width;

  Data({this.isSilhouette, this.height, this.url, this.width});

  Data.fromJson(Map<dynamic, dynamic> json) {
    isSilhouette = json['is_silhouette'];
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['is_silhouette'] = isSilhouette;
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}
