import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/search_bar.dart';
import 'package:market_finder/controllers/product_view_controller.dart';

class SearchProduct extends GetView<ProductViewController> {
  const SearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    // Barra de pesquisa com integração ao controlador
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Botão para voltar à tela anterior
        IconButton(
          iconSize:
              Get.height * 0.035, // Tamanho do ícone relativo à altura da tela
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Voltar à tela anterior
          },
        ),
        // Barra de pesquisa para buscar novos produtos
        SearchBarEdited(
          width: Get.width * 0.8, // Largura relativa à largura da tela
          height: Get.height * 0.06, // Altura relativa à altura da tela
          hint:
              'Diga-me do que precisa...', // Texto de dica na barra de pesquisa
          onSubmited: (text) {
            // Ação ao submeter um texto na barra de pesquisa
            controller.searchNewProduct(text, context);
          },
          controller:
              controller.searchBarcontroller, // Controlador para o texto
        ),
      ],
    );
  }
}
