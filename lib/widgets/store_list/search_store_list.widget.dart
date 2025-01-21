import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_circular.dart';
import 'package:market_finder/components/text_fild/search_bar.dart';
import 'package:market_finder/controllers/store_list_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

/// Componente de topo da tela para a lista de produtos da loja.
/// Inclui uma barra de pesquisa e um botão para criar novos produtos.
class SearchStoreList extends GetView<StoreListController> {
  const SearchStoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceAround, // Distribui os elementos de forma espaçada.
      children: [
        // Barra de pesquisa para buscar produtos cadastrados.
        SearchBarEdited(
          width: Get.width * 0.75, // Define a largura da barra de pesquisa.
          hint:
              'Algo já cadastrado?', // Texto de placeholder na barra de pesquisa.
          onSubmited: (text) {
            controller.setTextSearch(
                text); // Atualiza o texto de busca no controller.
          },
          height: Get.height * 0.06, // Define a altura da barra de pesquisa.
          controller: controller
              .searchBarcontroller, // Controlador vinculado ao campo de texto.
        ),
        // Botão circular para adicionar um novo produto.
        CircularButton(
          onPressed: () {
            controller.openEditProductView(context, -1);
            // Abre a tela de criação/edição de produto com o índice -1 indicando um novo produto.
          },
          icon: AppTheme.icons.add, // Ícone de adição.
          size: Get.height * 0.03, // Define o tamanho do botão.
        ),
      ],
    );
  }
}
