import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/card_product.dart';
import 'package:market_finder/controllers/search_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/search_page/page_counter_search.widget.dart';

class CardsSearchPage extends GetView<ProductSearchController> {
  const CardsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de produtos exibidos como cartões, 2 por linha
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          // Exibição do indicador de carregamento enquanto os dados são carregados
          return Center(
            child: CircularProgressIndicator(
              color: AppTheme.colors.primary,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: (controller.productsCards.length / 2).ceil(),
            itemBuilder: (context, index) {
              // Produtos exibidos em pares (esquerda e direita)
              final leftCard = controller.productsCards[index * 2];
              final rightCard =
                  (index * 2 + 1 < controller.productsCards.length)
                      ? controller.productsCards[index * 2 + 1]
                      : null;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Cartão do produto à esquerda
                        SearchCardProduct(
                          onTap: () {
                            controller.navigateToProductView(context, leftCard);
                          },
                          img: leftCard.img,
                          nameProduct: leftCard.productName,
                          valueProduct: leftCard.productValue,
                          nameStore: leftCard.storeName,
                          un: leftCard.un,
                          haveDelivery: leftCard.haveDelivery,
                          width: Get.width * 0.42,
                          height: Get.height * 0.25,
                          onAddCartTap: () {
                            controller.addProductToCart(index * 2);
                          },
                        ),
                        if (rightCard != null)
                          // Cartão do produto à direita (se disponível)
                          SearchCardProduct(
                            onTap: () {
                              controller.navigateToProductView(
                                  context, rightCard);
                            },
                            img: rightCard.img,
                            nameProduct: rightCard.productName,
                            valueProduct: rightCard.productValue,
                            nameStore: rightCard.storeName,
                            un: rightCard.un,
                            haveDelivery: rightCard.haveDelivery,
                            width: Get.width * 0.42,
                            height: Get.height * 0.25,
                            onAddCartTap: () {
                              controller.addProductToCart(index * 2 + 1);
                            },
                          ),
                      ],
                    ),
                  ),
                  if (index == (controller.productsCards.length / 2).ceil() - 1)
                    // Exibição do contador de páginas no final da lista
                    const PageCounterSearchPage(),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
