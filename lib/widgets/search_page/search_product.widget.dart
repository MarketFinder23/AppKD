import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/search_bar.dart';
import 'package:market_finder/controllers/search_controller.dart';

class SearchProductSearchPage extends GetView<ProductSearchController> {
  const SearchProductSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Renderiza a barra de busca com integração ao controlador
    return SearchBarEdited(
      width: Get.width *
          0.85, // Largura da barra de busca como 85% da largura da tela
      height: Get.height *
          0.06, // Altura da barra de busca como 6% da altura da tela
      hint: 'Digite o que procura...', // Texto de dica na barra de busca
      onSubmited: (text) {
        // Aciona a busca ao submeter o texto
        controller.setSearchQuery(text);
      },
      controller: controller
          .searchBarController, // Controlador para o texto da barra de busca
    );
  }
}
