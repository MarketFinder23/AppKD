class StoreInfos {
  /* --- Modelo de formuilario para infos da loja --- */
  String corporateReason; //Razão social
  String fantasiName; // Nome fantasia
  String phoneNumber;
  String whatsapp;
  String email;
  String cnpj;
  String password;
  String addressID;

  StoreInfos({
    required this.fantasiName,
    required this.corporateReason,
    required this.phoneNumber,
    required this.whatsapp,
    required this.email,
    required this.cnpj,
    required this.password,
    required this.addressID,
  });
  /* --- Função que converte o objeto em json --- */
  Map<String, dynamic> toJson() {
    return {
      'fantasiName': fantasiName,
      'corporateReason': corporateReason,
      'phoneNumber': phoneNumber,
      'whatsapp': whatsapp,
      'email': email,
      'cnpj': cnpj,
      'password': password,
      'addressID': addressID,
    };
  }

/* --- Função que converte json em um objeto --- */
  factory StoreInfos.fromJson(Map<String, dynamic> json) {
    return StoreInfos(
      corporateReason: json['corporateReason'],
      fantasiName: json['fantasiName'],
      phoneNumber: json['phoneNumber'],
      whatsapp: json['whatsapp'],
      email: json['email'],
      cnpj: json['cnpj'],
      password: json['password'],
      addressID: json['addressID'],
    );
  }
}
