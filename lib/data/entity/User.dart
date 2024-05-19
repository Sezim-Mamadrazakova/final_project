
class User {
  final String idUser;
  final String email;
  final String password;

  User({
    required this.idUser,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{idUser: $idUser, email: $email, password: $password}';
  }
}
