class User {
  int id;
  String name;
  //String phone;
  //String fax;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int,
      name: json["name"] as String,
      //phone: json["phone"] as String,
      //fax: json["fax"] as String,
    );
  }
}