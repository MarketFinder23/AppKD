import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/pages_counter.dart';
import 'package:market_finder/controllers/search_controller.dart';

class PageCounterSearchPage extends GetView<ProductSearchController> {
  const PageCounterSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contador de páginas para navegação na tela de busca
    return Obx(() {
      return PagesCounter(
        actualPage: controller.currentPage.value, // Página atual
        totalPages: controller.totalPages.value, // Total de páginas disponíveis
        onPageChanged: (int page) {
          // Ação ao mudar de página
          controller.onPageChanged(page);
        },
        height: Get.height * 0.07, // Altura do componente
        width: Get.width * 0.9, // Largura do componente
      );
    });
  }
}
