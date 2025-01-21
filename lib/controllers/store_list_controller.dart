import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/components/show_dialog.dart';
import 'package:market_finder/models/product.dart';
import 'package:market_finder/models/store.dart';
import 'package:market_finder/screens/store_list/product_edit_page.dart';
import 'package:market_finder/services/list_poroducts_store_service.dart';
import 'package:market_finder/services/products_service.dart';
import 'package:market_finder/services/store_service.dart';

/// Controlador responsável por gerenciar a tela de lista de produtos de uma loja.
class StoreListController extends GetxController {
  // Controlador para o campo de pesquisa
  final TextEditingController searchBarcontroller = TextEditingController();

  // Serviços usados na tela de produtos da loja
  final ListPoroductsStoreService storeListService =
      ListPoroductsStoreService();
  final ProductService productService = ProductService();
  final StoreService storeService = StoreService();

  // Componente para exibir mensagens ao usuário
  final BoxMessage boxMessage = BoxMessage();

  // Variáveis observáveis para controle da interface
  var productsCards =
      <ProductsInfos>[].obs; // Lista de produtos exibidos na tela
  var textSearch = 'text'.obs; // Texto da barra de pesquisa
  var actualPage = 1.obs; // Página atual
  var totalPages = 20.obs; // Total de páginas disponíveis
  var isLoading = false.obs; // Indica se os dados estão carregando

  // Informações da loja
  late StoreInfos storeInfos;

  /// Inicializa o controlador e busca os dados da loja e seus produtos.
  @override
  void onInit() async {
    super.onInit();
    // Obtém as informações da loja e gera os produtos para exibição
    storeInfos = await storeService.getStore();
    productGenerate();
  }

  /// Atualiza os produtos quando a página é alterada.
  void onPageChanged(int page) {
    actualPage.value = page;
    productGenerate();
  }

  /// Define o texto de pesquisa e realiza a busca.
  void setTextSearch(String text) {
    textSearch.value = text;
    actualPage.value = 1; // Reinicia para a primeira página
    productGenerate();
  }

  /// Exibe uma caixa de diálogo para confirmar a exclusão de um produto.
  void showConfirmDeleteProduct(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDialog(
          title:
              "Tem certeza que deseja excluir o produto ${productsCards[index].productName}?",
          onConfirm: () async {
            try {
              isLoading.value = true; // Ativa o estado de carregamento
              String result = await productService.deleteProduct(
                productsCards[index].id,
                storeInfos.email,
                storeInfos.password,
              );

              if (result == 'Produto deletado com sucesso') {
                showMessage(result); // Exibe mensagem de sucesso
                productsCards.removeAt(index); // Remove o produto da lista
                productGenerate(); // Atualiza a lista de produtos
              } else {
                showMessage(
                    'Erro ao deletar o produto, tente novamente mais tarde!');
              }
            } catch (e) {
              showMessage('Erro inesperado: ${e.toString()}');
            }
          },
          height: Get.height * 0.1,
          width: Get.width * 0.3,
          textNegative: 'NÃO',
          textPositive: 'SIM',
        );
      },
    );
  }

  /// Abre a tela de edição ou cadastro de um novo produto.
  void openEditProductView(BuildContext context, int index) {
    late ProductsInfos productsInfos;

    if (index == -1) {
      // Criação de um novo produto com valores padrão
      productsInfos = ProductsInfos(
        storeName: '',
        productValue: '',
        productName: '',
        description: '',
        img: '',
        un: 'Un',
        haveDelivery: false,
        id: '',
        haveEmail: false,
        havePhone: false,
        haveWhats: false,
        phoneNumber: ' ',
        qnt: 1,
      );
    } else {
      // Edição de um produto existente
      productsInfos = productsCards[index];
    }

    // Navega para a tela de edição/cadastro de produto
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductCadPage(
          productsInfos: productsInfos,
          storeInfos: storeInfos,
        ),
      ),
    );
  }

  /// Realiza a busca de produtos no backend com base no texto e na página atual.
  Future<void> productGenerate() async {
    isLoading.value = true;

    try {
      final result = await storeListService.searchProduct(
        textSearch.value, // Texto de pesquisa
        actualPage.value, // Página atual
        storeInfos.email,
        storeInfos.password,
      );

      // Atualiza a lista de produtos e o total de páginas
      productsCards.assignAll(result['products']);
      totalPages.value = result['totalPage'];
    } catch (e) {
      showMessage('Erro ao buscar produtos: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  /// Exibe mensagens para o usuário.
  void showMessage(String message) {
    BuildContext context = Get.context!;
    isLoading.value = false;
    boxMessage.showMessage(
      context: context,
      message: message,
    );
  }
}
