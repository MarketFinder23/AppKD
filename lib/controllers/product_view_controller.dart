import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/controllers/external_apps_controller.dart';
import 'package:market_finder/models/product.dart';
import 'package:market_finder/services/cart_service.dart';
import 'package:market_finder/services/contacts_service.dart';
import 'package:market_finder/services/search_service.dart';

class ProductViewController extends GetxController {
  // Controllers para a tela de visualização de produtos
  final TextEditingController searchBarcontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Serviços utilizados na tela de produtos
  final SearchProductsService searchProductsService = SearchProductsService();
  final ContactsService contactsService = ContactsService();
  final CartServices cartServices = CartServices();

  // Variáveis observáveis para gerenciamento de estado
  var selectedProduct = Rx<ProductsInfos?>(null);
  var productsSimilarCards = <ProductsInfos>[].obs;
  var productsStoresCards = <ProductsInfos>[].obs;
  var similarProducIsLoading = false.obs;
  var storeProducIsLoading = false.obs;
  var productIsLoading = false.obs;

  // Variáveis de contato e localização
  late String phoneNumber = '';
  late String email = '';
  late String location = '';
  late String distance = '';

  // Imagem do produto
  late Uint8List bytes;

  // Utilitários
  final BoxMessage boxMessage = BoxMessage();
  final ExternalAppsController externalAppsController =
      ExternalAppsController();

  // Inicializa valores fixos para os widgets
  void initializeValues() {
    if (selectedProduct.value != null) {
      bytes = base64Decode(selectedProduct.value!.img);
    }
  }

  // Retorna para a tela de busca com um novo texto
  void searchNewProduct(String text, BuildContext context) {
    Navigator.pop(context, text);
  }

  // Atualiza a visualização para um novo produto
  void attProductView(ProductsInfos newProduct) {
    selectedProduct.value = newProduct;
    loadContacts();
    generateSimilarCards();
    generateStoreCards();
  }

  // Carrega os contatos do produto
  Future<void> loadContacts() async {
    productIsLoading.value = true;

    try {
      final result = await contactsService
          .contactsInfos(selectedProduct.value!.id.toString());

      location = result['location'] ?? 'Sem localização';
      phoneNumber = result['phone'] ?? 'Sem telefone';
      email = result['mail'] ?? 'Sem Email';
      distance = result['distance'] ?? '????m';
    } catch (e) {
      // Tratar erros se necessário
      location = 'Sem localização';
      phoneNumber = 'Sem telefone';
      email = 'Sem Email';
      distance = '????m';
    } finally {
      productIsLoading.value = false;
    }
  }

  // Gera os cartões de produtos similares
  Future<void> generateSimilarCards() async {
    similarProducIsLoading.value = true;
    try {
      final result = await searchProductsService.searchProduct(
        selectedProduct.value!.productName,
        1,
      );
      productsSimilarCards.assignAll(result['products']);
    } catch (e) {
      productsSimilarCards.clear();
    } finally {
      similarProducIsLoading.value = false;
    }
  }

  // Gera os cartões de produtos da mesma loja
  Future<void> generateStoreCards() async {
    storeProducIsLoading.value = true;
    try {
      final result = await searchProductsService.searchProduct(
        'loja ${selectedProduct.value!.storeName}',
        1,
      );
      productsStoresCards.assignAll(result['products']);
    } catch (e) {
      productsStoresCards.clear();
    } finally {
      storeProducIsLoading.value = false;
    }
  }

  // Adiciona um produto ao carrinho
  Future<void> addToCart(BuildContext context, String productID) async {
    try {
      String response = await cartServices.addCartProduct(productID);

      if (context.mounted) {
        if (response == 'erro') {
          boxMessage.showMessage(
            context: context,
            message: 'Erro ao adicionar produto ao Carrinho',
          );
        } else {
          boxMessage.showMessage(
            context: context,
            message: 'Produto adicionado ao carrinho',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        boxMessage.showMessage(context: context, message: 'Erro: $e');
      }
    }
  }

  // Ações externas para interação com a loja
  void calltoStore() {
    externalAppsController.calltoStore(phoneNumber);
  }

  void emailtoStore() {
    externalAppsController.emailtoStore(email);
  }

  void whatstoStore() {
    externalAppsController.whatstoStore(selectedProduct.value!.phoneNumber);
  }

  void maptoStore() {
    externalAppsController.maptoStore(location);
  }
}
