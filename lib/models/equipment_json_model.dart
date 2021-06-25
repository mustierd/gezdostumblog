class EquipmentJson {
  int userId;
  int id;
  String title;
  String body;
  String url;

  EquipmentJson({this.userId, this.id, this.title, this.body, this.url});

  factory EquipmentJson.fromJson(Map<String, dynamic> json) {
    return EquipmentJson(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
      url: json["url"],
    );
  }
}
