import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/widgets/store_list/listcard_register.dart';
import 'package:market_finder/controllers/store_list_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

/// Widget responsável por exibir a lista de produtos cadastrados pela loja.
/// Inclui um indicador de carregamento enquanto os dados estão sendo buscados.
class ProductsStoreList extends GetView<StoreListController> {
  const ProductsStoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expande o widget para ocupar o espaço disponível na tela.
      child: Obx(() {
        // Observa alterações na variável `isLoading` do controller.
        if (controller.isLoading.value) {
          // Exibe um indicador de carregamento enquanto os dados são buscados.
          return Center(
            child: CircularProgressIndicator(
              color: AppTheme.colors.primary, // Define a cor do indicador.
            ),
          );
        } else {
          // Exibe a lista de produtos cadastrados quando os dados estão disponíveis.
          return ListView.builder(
            itemCount:
                controller.productsCards.length, // Número de itens na lista.
            itemBuilder: (context, index) {
              return Padding(
                // Adiciona espaçamento ao redor de cada cartão.
                padding: EdgeInsets.only(
                  bottom: Get.height * 0.025, // Espaço inferior entre os itens.
                  left: Get.width * 0.05, // Espaço à esquerda.
                  right: Get.width * 0.05, // Espaço à direita.
                ),
                child: ListCardRegister(
                  index:
                      index, // Passa o índice do item para o widget de cartão.
                ),
              );
            },
          );
        }
      }),
    );
  }
}
