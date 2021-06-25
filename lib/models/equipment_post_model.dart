class EquipmentPostModel {
  int id;
  String product;
  String userName;
  String title;
  String body;
  String email;
  String image;

  EquipmentPostModel(
      {this.product,
      this.userName,
      this.title,
      this.body,
      this.email,
      this.image});
  EquipmentPostModel.withId(
      {this.id,
      this.product,
      this.userName,
      this.title,
      this.body,
      this.email,
      this.image});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["product"] = product;
    map["userName"] = userName;
    map["title"] = title;
    map["body"] = body;
    map["email"] = email;
    map["image"] = image;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  EquipmentPostModel.fromObject(dynamic o) {
    id = (o["id"]);
    product = o["product"];
    userName = o["userName"];
    title = o["title"];
    body = o["body"];
    email = o["email"];
    image = o["image"];
  }
}
