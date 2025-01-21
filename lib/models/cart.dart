import 'package:get/get.dart';
import 'package:market_finder/models/product.dart';

class CartInfos {
  /* --- Infos da Loja --- */
  final String storeName;
  final String email;
  final String phone;
  final String whats;
  final bool haveDelivery;
  final List<ProductsInfos> products;

  var isOpen = false.obs; // Propriedade observável
  var totalStore = '0.00'.obs; // Total da loja como observável

  CartInfos({
    required this.storeName,
    required this.email,
    required this.phone,
    required this.whats,
    required this.products,
    required this.haveDelivery,
    bool isOpen = false,
  }) {
    this.isOpen.value = isOpen;
  }

  /* --- Função que converte JSON em um objeto --- */
  factory CartInfos.fromJson(Map<String, dynamic> json) {
    return CartInfos(
      haveDelivery: json['haveDelivery'] ?? false, // Valor padrão se for null
      storeName: json['storeName'] ?? '', // Substitui por string vazia
      email: json['email'] ?? '', // Substitui por string vazia
      phone: json['phone'] ?? '', // Substitui por string vazia
      whats: json['whats'] ?? '', // Substitui por string vazia
      products: (json['products'] as List? ?? []) // Substitui por lista vazia
          .map((item) => ProductsInfos.fromJson(item))
          .toList(),
    );
  }

  /* --- Função que converte o objeto em JSON --- */
  Map<String, dynamic> toJson() {
    return {
      'storeName': storeName,
      'email': email,
      'phone': phone,
      'whats': whats,
      'products': products.map((item) => item.toJson()).toList(),
      'haveDelivery': haveDelivery,
    };
  }
}
