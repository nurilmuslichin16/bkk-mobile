class UserModel {
  int id;
  String name;
  String nisn;

  UserModel({
    this.id,
    this.name,
    this.nisn,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nisn = json['nisn'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nisn': nisn,
    };
  }
}
