import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/cart_controller.dart';
import 'package:market_finder/widgets/cart_page/store_card_cart.widget.dart';

class ListStoreCart extends GetView<CartController> {
  const ListStoreCart({super.key});

  // Cria a lista de cartões de lojas com espaçamento entre eles
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          // Exibe o indicador de carregamento enquanto os dados estão sendo processados
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Constrói uma lista de cartões com base nos dados do carrinho
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.cartCards.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: Get.height * 0.02, // Espaçamento inferior
                  left: Get.width * 0.03, // Espaçamento lateral esquerdo
                  right: Get.width * 0.03, // Espaçamento lateral direito
                ),
                child: CardStoreCart(
                  indexStore: index, // Índice do cartão correspondente à loja
                  width: Get.width * 0.9, // Largura do cartão
                  heigth: Get.height * 0.15, // Altura do cartão
                ),
              );
            },
          );
        }
      }),
    );
  }
}
