import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/card_product.dart';
import 'package:market_finder/controllers/product_view_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

class CardsProductStores extends GetView<ProductViewController> {
  const CardsProductStores({super.key});

  @override
  Widget build(BuildContext context) {
    // Construção dos cards de produtos relacionados à loja
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da sessão
        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.05),
          child: SizedBox(
            width: Get.width * 0.9,
            child: Text(
              "Aproveite e leve também:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: Get.height * 0.03,
                fontFamily: AppTheme.fonts.primaryFont,
              ),
            ),
          ),
        ),
        // Lista horizontal de cartões de produtos
        SizedBox(
          height: Get.height * 0.35,
          child: Obx(() {
            if (controller.storeProducIsLoading.value) {
              // Indicador de carregamento enquanto os dados são carregados
              return Center(
                child: CircularProgressIndicator(
                  color: AppTheme.colors.primary,
                ),
              );
            } else {
              // Exibição dos cartões quando os dados estiverem disponíveis
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.productsStoresCards.length,
                    (index) {
                      final product = controller.productsStoresCards[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SearchCardProduct(
                          onTap: () {
                            // Atualiza a visualização do produto selecionado
                            controller.attProductView(product);
                            controller.scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                          },
                          img: product.img,
                          nameProduct: product.productName,
                          valueProduct: product.productValue,
                          nameStore: product.storeName,
                          un: product.un,
                          width: Get.width * 0.45,
                          height: Get.height * 0.3,
                          haveDelivery: product.haveDelivery,
                          onAddCartTap: () {
                            controller.addToCart(context, product.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
