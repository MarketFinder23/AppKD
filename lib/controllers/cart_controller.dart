import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/components/show_dialog.dart';
import 'package:market_finder/controllers/external_apps_controller.dart';
import 'package:market_finder/models/cart.dart';
import 'package:market_finder/services/cart_service.dart';
import 'package:market_finder/services/contacts_service.dart';

class CartController extends GetxController {
  // Controller da barra de pesquisa
  final TextEditingController searchCardController = TextEditingController();

  // Serviços da página
  final CartServices cardServices = CartServices();
  final ContactsService contactsService = ContactsService();

  // Utilitários
  final BoxMessage boxMessage = BoxMessage();
  final ExternalAppsController externalAppsController =
      ExternalAppsController();

  // Variáveis observáveis para controle da tela de carrinhos
  var cartCards = <CartInfos>[].obs;
  var textSearch = 'text'.obs;
  var isLoading = false.obs;
  var location = <String>[].obs;
  var distance = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    cardGenerate(); // Inicializa os dados do carrinho
  }

  // Alterna o estado de expansão de um cartão
  void switchSizeCard(int idStore) {
    cartCards[idStore].isOpen.value = !cartCards[idStore].isOpen.value;
  }

  // Atualiza a quantidade do produto no backend e na interface
  Future<bool> attQnt(
      BuildContext context, int idStore, int idProduct, int value) async {
    String message = await cardServices.attQntProduct(
      cartCards[idStore].products[idProduct].productName,
      cartCards[idStore].products[idProduct].id,
    );

    if (message == "Atualização bem sucedida") {
      attTotalStore(idStore, idProduct, value);
      if (context.mounted) {
        showMessage(context, 'Atualização bem sucedida');
        return true;
      }
    } else {
      if (context.mounted) {
        showMessage(context, 'Erro ao atualizar Quantidade');
      }
    }
    return false;
  }

  // Atualiza o total da loja e a quantidade do produto
  void attTotalStore(int idStore, int idProduct, int value) {
    cartCards[idStore].products[idProduct].qnt.value = value;
    calcularTotal(idStore);
  }

  // Calcula o total de uma loja com base nos produtos
  void calcularTotal(int idStore) {
    double total = cartCards[idStore].products.fold(0.0, (sum, item) {
      String sanitizedValue =
          item.productValue.replaceAll(RegExp(r'[^0-9.]'), '');
      double productValue = double.tryParse(sanitizedValue) ?? 0.0;
      return sum + (productValue * item.qnt.value);
    });
    cartCards[idStore].totalStore.value = total.toStringAsFixed(2);
  }

  // Atualiza os cartões com base no texto de busca
  void searchCard(String text) {
    textSearch.value = text;
    cardGenerate();
  }

  // Mostra o diálogo de confirmação para exclusão
  void showConfirmaDeleteDialog(
      BuildContext context, int idStore, int idProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDialog(
          title:
              "Tem certeza que deseja excluir o produto ${cartCards[idStore].products[idProduct].productName}?",
          onConfirm: () async {
            deleteProductCard(context, idStore, idProduct);
          },
          height: Get.height * 0.1,
          width: Get.width * 0.3,
          textNegative: 'NÃO',
          textPositive: 'SIM',
        );
      },
    );
  }

  // Gera os cartões do backend e atualiza o estado
  Future<void> cardGenerate() async {
    isLoading.value = true;

    try {
      final result = await cardServices.searchCartCards(textSearch.value);
      cartCards.value = result;

      // Calcula o total para cada loja
      for (int id = 0; id < cartCards.length; id++) {
        calcularTotal(id);
      }

      cartCards.refresh();

      // Inicializa as listas de localização e distância
      location.value = List.generate(cartCards.length, (_) => 'Carregando...');
      distance.value = List.generate(cartCards.length, (_) => 'Carregando...');

      // Carrega os contatos de forma assíncrona
      for (int id = 0; id < cartCards.length; id++) {
        await loadContacts(id);
      }
    } catch (e) {
      // Lida com erros se necessário
    } finally {
      isLoading.value = false;
    }
  }

  // Remove um produto do carrinho
  Future<void> deleteProductCard(
      BuildContext context, int indexStore, int index) async {
    String message = await cardServices.deleteCartProduct(
      cartCards[indexStore].products[index].productName,
      cartCards[indexStore].products[index].id,
    );
    if (context.mounted) {
      showMessage(context, message);
    }
    if (message.contains('sucesso')) {
      cartCards[indexStore].products.removeAt(index);
      if (cartCards[indexStore].products.isEmpty) {
        cartCards.removeAt(indexStore);
      } else {
        calcularTotal(indexStore);
      }
      cartCards.refresh();
    }
  }

  // Carrega os contatos de uma loja específica
  Future<void> loadContacts(int index) async {
    try {
      final result =
          await contactsService.contactsInfos(cartCards[index].products[0].id);

      location[index] = result['location'] ?? 'Sem localização';
      distance[index] = result['distance'] ?? '????m';
    } catch (e) {
      location[index] = 'Sem localização';
      distance[index] = '????m';
    }
  }

  // Mostra uma mensagem na tela
  void showMessage(BuildContext context, String message) {
    boxMessage.showMessage(context: context, message: message);
  }

  // Ações externas para interação com a loja
  void calltoStore(String phoneNumber) {
    externalAppsController.calltoStore(phoneNumber);
  }

  void emailtoStore(String email) {
    externalAppsController.emailtoStore(email);
  }

  void whatstoStore(String whatsNumber) {
    externalAppsController.whatstoStore(whatsNumber);
  }

  void maptoStore(String location) {
    externalAppsController.maptoStore(location);
  }
}
