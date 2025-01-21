import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/product_view_controller.dart';
import 'package:market_finder/models/product.dart';
import 'package:market_finder/widgets/product_view/cards_similar_products.widget.dart';
import 'package:market_finder/widgets/product_view/cards_stores_products.widget.dart';
import 'package:market_finder/widgets/product_view/product_infos.widget.dart';
import 'package:market_finder/widgets/product_view/search_product.widget.dart';

class ProductView extends GetView<ProductViewController> {
  // Deve receber um produto para carregar na tela
  final ProductsInfos productsInfos;

  ProductView({
    super.key,
    required this.productsInfos,
  }) {
    // Atualiza o controlador com as informações do produto e inicializa valores necessários
    controller.attProductView(productsInfos);
    controller.initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    // Construção da tela principal do produto
    return SingleChildScrollView(
      controller: controller.scrollController, // Controlador de rolagem
      child: Padding(
        padding:
            EdgeInsets.only(top: Get.height * 0.06), // Espaçamento superior
        child: const Column(
          children: [
            SearchProduct(), // Barra de pesquisa
            ProductsInfosView(), // Informações do produto atual
            CardsProductStores(), // Lista de produtos relacionados à loja
            CardsProductSimilars(), // Lista de produtos similares
          ],
        ),
      ),
    );
  }
}
