import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/models/product.dart';
import 'package:market_finder/screens/product_view_page.dart';
import 'package:market_finder/services/cart_service.dart';
import 'package:market_finder/services/search_service.dart';

class ProductSearchController extends GetxController {
  // Controlador para a barra de pesquisa
  final TextEditingController searchBarController = TextEditingController();

  // Serviços utilizados para busca e carrinho
  final SearchProductsService searchProductsService = SearchProductsService();
  final CartServices cartServices = CartServices();

  // Componente de mensagens para feedback ao usuário
  final BoxMessage boxMessage = BoxMessage();

  // Variáveis observáveis para atualizar a UI em tempo real
  var productsCards = <ProductsInfos>[].obs;
  var searchQuery = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoading = false.obs;

  // Atualiza a página atual e faz a busca novamente
  void onPageChanged(int page) {
    currentPage.value = page;
    fetchProducts();
  }

  // Define o texto da busca e realiza uma nova busca
  void setSearchQuery(String query) {
    searchBarController.text = query;
    searchQuery.value = query;
    currentPage.value = 1;
    fetchProducts();
  }

  // Busca os produtos do backend com base no texto de busca e na página atual
  Future<void> fetchProducts() async {
    isLoading.value = true;

    try {
      final result = await searchProductsService.searchProduct(
        searchQuery.value,
        currentPage.value,
      );

      final List<ProductsInfos> products = result['products'] ?? [];
      if (products.isEmpty) {
        // Use um post-frame callback para exibir a mensagem
        WidgetsBinding.instance.addPostFrameCallback((_) {
          boxMessage.showMessage(
            context: Get.context!,
            message: 'Nenhum produto encontrado. Tente novamente mais tarde.',
          );
        });
      } else {
        productsCards.assignAll(products);
        totalPages.value = result['totalPage'] ?? 1;
      }
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        boxMessage.showMessage(
          context: Get.context!,
          message: 'Erro ao buscar produtos. Por favor, tente novamente.',
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  // Adiciona um produto ao carrinho e exibe mensagens de feedback
  Future<void> addProductToCart(int index) async {
    try {
      final productId = productsCards[index].id;
      final message = await cartServices.addCartProduct(productId);

      if (message.contains('erro')) {
        boxMessage.showMessage(
          context: Get.context!,
          message: message,
        );
      } else {
        boxMessage.showMessage(
          context: Get.context!,
          message: 'Produto adicionado ao carrinho!',
        );
      }
    } catch (error) {
      boxMessage.showMessage(
        context: Get.context!,
        message: 'Erro ao adicionar produto ao carrinho.',
      );
    }
  }

  // Navega para a tela de visualização do produto e espera um texto de retorno para caso de rebusca
  void navigateToProductView(
      BuildContext context, ProductsInfos product) async {
    final searchText = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductView(
          productsInfos: product,
        ),
      ),
    );

    // Verifica se há um valor retornado e faz uma nova busca
    if (searchText != null) {
      setSearchQuery(searchText);
    }
  }
}
