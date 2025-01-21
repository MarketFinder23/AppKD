class UserInfos {
  /* --- Modelo de formuilario para infos do usuario --- */
  String name;
  String phoneNumber;
  String email;
  String cpf;
  String password;
  String addressID;

  UserInfos({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.cpf,
    required this.password,
    required this.addressID,
  });
  /* --- Função que converte o objeto em json --- */
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'cpf': cpf,
      'password': password,
      'addressID': addressID,
    };
  }

/* --- Função que converte json em um objeto --- */
  factory UserInfos.fromJson(Map<String, dynamic> json) {
    return UserInfos(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      cpf: json['cpf'],
      password: json['password'],
      addressID: json['addressID'],
    );
  }
}
