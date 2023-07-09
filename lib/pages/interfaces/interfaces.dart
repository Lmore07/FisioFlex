class Credentials {
  final String user;
  final String password;

  Credentials({required this.user, required this.password});
}

class MyInformation {
  final String? names;
  final String? image;
  final String? identification;
  final String? phone;
  final String? description;

  MyInformation(
      {this.names,
      this.image,
      this.identification,
      this.phone,
      this.description});
  factory MyInformation.fromJson(Map<String, dynamic> json) {
    return MyInformation(
      names: json['names'],
      image: json['image'],
      identification: json['identification'],
      phone: json['phone'],
      description: json['description'],
    );
  }
}
