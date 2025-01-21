import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/store_list_controller.dart';
import 'package:market_finder/widgets/store_list/products_store_list.widget.dart';
import 'package:market_finder/widgets/store_list/page_counter_store.widget.dart';
import 'package:market_finder/widgets/store_list/search_store_list.widget.dart';

/// Página que exibe a lista de produtos cadastrados por uma loja.
/// Inclui barra de pesquisa, lista de produtos e um contador de páginas.
class ProductListStorePage extends StatelessWidget {
  ProductListStorePage({super.key});

  // Inicialização do controller responsável por gerenciar o estado da página.
  final StoreListController controller = Get.put(StoreListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Get.height * 0.06), // Espaçamento superior para alinhamento.
      child: const Column(
        children: [
          SearchStoreList(), // Barra de pesquisa com opção de criar novo produto.
          ProductsStoreList(), // Exibição da lista de produtos cadastrados pela loja.
          PageCounterStoreList(), // Componente de paginação para navegar entre os produtos.
        ],
      ),
    );
  }
}
