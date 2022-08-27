class MySlider {
  final int id;
  final String imgUrl;
  final String title;
  final String desc;
  final String creator;

  const MySlider(
      {required this.id,
      required this.imgUrl,
      required this.title,
      required this.desc,
      required this.creator});

  @override
  String toString() {
    return '{${this.id}, ${this.title}, ${this.desc}, ${this.creator}, ${this.imgUrl}}';
  }
}

class Userqu {
  String id;
  final String name;
  final String email;
  final String password;

  Userqu(
      {this.id = '',
      required this.name,
      required this.email,
      this.password = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  static Userqu fromJson(Map<String, dynamic> json) => Userqu(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );
}
