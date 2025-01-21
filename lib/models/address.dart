class AddressInfos {
  // Modelo de formuilario para infos do endereço do usuario
  String cep;
  String city;
  String neighborhood;
  String street;
  String number;
  String complement;
  String id;

  AddressInfos({
    required this.cep,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.number,
    required this.complement,
    required this.id,
  });
  /* --- Função que converte o objeto em json --- */
  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'city': city,
      'neighborhood': neighborhood,
      'street': street,
      'number': number,
      'complement': complement,
      'id': id,
    };
  }

/* --- Função que converte json em um objeto --- */
  factory AddressInfos.fromJson(Map<String, dynamic> json) {
    return AddressInfos(
      cep: json['cep'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
      number: json['number'],
      complement: json['complement'],
      id: json['id'],
    );
  }
}
