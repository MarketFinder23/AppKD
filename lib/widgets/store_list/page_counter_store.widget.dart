import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/pages_counter.dart';
import 'package:market_finder/controllers/store_list_controller.dart';

/// Widget responsável por exibir o contador de páginas para navegação na lista de produtos.
class PageCounterStoreList extends GetView<StoreListController> {
  const PageCounterStoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Observa mudanças nas variáveis `actualPage` e `totalPages` do controller.
      return PagesCounter(
        actualPage: controller.actualPage.value, // Página atual.
        totalPages:
            controller.totalPages.value, // Total de páginas disponíveis.
        onPageChanged: (int page) {
          // Atualiza a página ao mudar no contador.
          controller.onPageChanged(page);
        },
        height: Get.height * 0.05, // Altura do contador.
        width: Get.width * 0.9, // Largura do contador.
      );
    });
  }
}
