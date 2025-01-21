import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/cart_controller.dart';
import 'package:market_finder/widgets/cart_page/list_store_cart.widget.dart';
// import 'package:market_finder/widgets/cart_page/cart_search_page.widget.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({super.key});

  // Inicialização do controlador da página de carrinho
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.06), // Espaçamento superior
      child: const Column(
        children: [
          // SearchCartPage(), // Barra de pesquisa (comentada para possível implementação futura)
          ListStoreCart(), // Lista de cartões com lojas e produtos associados
        ],
      ),
    );
  }
}
