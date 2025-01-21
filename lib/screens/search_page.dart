import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/product_view_controller.dart';
import 'package:market_finder/controllers/search_controller.dart';
import 'package:market_finder/widgets/search_page/cards_search_page.widget.dart';
import 'package:market_finder/widgets/search_page/search_product.widget.dart';

class SearchPage extends StatefulWidget {
  final String initialSearchText;

  const SearchPage({super.key, required this.initialSearchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  // Controlador para manipulação da lógica de busca
  final ProductSearchController _searchController =
      Get.put(ProductSearchController());

  @override
  void initState() {
    super.initState();

    // Inicializa o controlador de exibição dos produtos
    Get.put(ProductViewController());

    // Configura o texto inicial da barra de busca
    _searchController.setSearchQuery(widget.initialSearchText);

    // Preenche a barra de busca se o texto inicial for diferente do padrão
    if (widget.initialSearchText != 'text') {
      _searchController.searchBarController.text = widget.initialSearchText;
    }
  }

  @override
  bool get wantKeepAlive => true; // Mantém o estado da página ao alternar abas

  @override
  Widget build(BuildContext context) {
    super.build(context); // Necessário para AutomaticKeepAliveClientMixin

    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.06), // Espaçamento superior
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: const Column(
          children: [
            SearchProductSearchPage(), // Componente para a barra de busca
            CardsSearchPage(), // Lista de resultados da busca
          ],
        ),
      ),
    );
  }
}
