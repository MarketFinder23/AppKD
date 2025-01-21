import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/search_bar.dart';
import 'package:market_finder/controllers/cart_controller.dart';

class SearchCartPage extends GetView<CartController> {
  const SearchCartPage({super.key});

  // Barra de pesquisa na tela de carrinho para buscar lojas específicas
  @override
  Widget build(BuildContext context) {
    return SearchBarEdited(
      width: Get.width * 0.85, // Largura relativa à tela
      hint:
          'Procurando uma loja específica?', // Texto de dica na barra de busca
      onSubmited: (text) {
        // Ação ao submeter texto
        controller.searchCard(text);
      },
      height: Get.height * 0.06, // Altura relativa à tela
      controller:
          controller.searchCardController, // Controlador do texto de busca
    );
  }
}
