class pliGalery {
  int id;
  String name;
  //String phone;
  //String fax;

  pliGalery({this.id, this.name});

  factory pliGalery.fromJson(Map<String, dynamic> json) {
    return pliGalery(
      id: json["id"] as int,
      name: json["name"] as String,
      //phone: json["phone"] as String,
      //fax: json["fax"] as String,
    );
  }
}