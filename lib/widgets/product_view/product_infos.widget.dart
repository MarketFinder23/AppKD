import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_circular.dart';
import 'package:market_finder/components/descriptions.dart';
import 'package:market_finder/components/price.dart';
import 'package:market_finder/components/show_img.dart';
import 'package:market_finder/controllers/product_view_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

class ProductsInfosView extends GetView<ProductViewController> {
  const ProductsInfosView({super.key});

  @override
  Widget build(BuildContext context) {
    // Observa as alterações do estado e exibe o carregamento até que os dados estejam disponíveis
    return Obx(() {
      if (controller.productIsLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppTheme.colors.primary,
          ),
        );
      }
      return SizedBox(
        width: Get.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome do produto
            Text(
              controller.selectedProduct.value!.productName,
              style: TextStyle(
                fontSize: Get.height * 0.05,
                fontFamily: AppTheme.fonts.primaryFont,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Imagem do produto
                SizedBox(
                  width: Get.width * 0.4,
                  child: buildImage(
                    controller.selectedProduct.value!.img,
                    Get.width * 0.4,
                    Get.height * 0.1,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nome da loja
                          Text(
                            controller.selectedProduct.value!.storeName,
                            style: TextStyle(
                              fontSize: Get.height * 0.03,
                              fontFamily: AppTheme.fonts.primaryFont,
                            ),
                          ),
                          // Botão para adicionar ao carrinho
                          CircularButton(
                            onPressed: () {
                              controller.addToCart(context,
                                  controller.selectedProduct.value!.id);
                            },
                            icon: AppTheme.icons.cart,
                            size: Get.height * 0.03,
                          ),
                        ],
                      ),
                      // Preço do produto
                      Price(
                        productValue:
                            controller.selectedProduct.value!.productValue,
                        measurUnity: controller.selectedProduct.value!.un,
                        width: Get.width * 0.45,
                        height: Get.height * 0.1,
                        fontSize: Get.height * 0.025,
                        fontFamily: AppTheme.fonts.primaryFont,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Ícone de entrega se disponível
                      SizedBox(
                        height: Get.height * 0.2,
                        child: controller.selectedProduct.value!.haveDelivery
                            ? Icon(
                                AppTheme.icons.delivery,
                                size: Get.height * 0.02,
                              )
                            : null,
                      ),
                      // Distância até a loja
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.02),
                        child: Text(
                          controller.distance, // Atualizado pelo controlador
                          style: TextStyle(
                            fontFamily: AppTheme.fonts.primaryFont,
                            fontSize: Get.height * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Botão para abrir o mapa da loja
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.01),
                          child: CircularButton(
                            onPressed: () {
                              controller.maptoStore();
                            },
                            icon: AppTheme.icons.gps,
                            size: Get.height * 0.03,
                          ),
                        ),
                        // Botão para ligar para a loja (se disponível)
                        if (controller.selectedProduct.value!.havePhone)
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.01),
                            child: CircularButton(
                              onPressed: () {
                                controller.calltoStore();
                              },
                              icon: AppTheme.icons.phone,
                              size: Get.height * 0.03,
                            ),
                          ),
                        // Botão para enviar e-mail para a loja (se disponível)
                        if (controller.selectedProduct.value!.haveEmail)
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.01),
                            child: CircularButton(
                              onPressed: () {
                                controller.emailtoStore();
                              },
                              icon: AppTheme.icons.letter,
                              size: Get.height * 0.03,
                            ),
                          ),
                        // Botão para abrir o WhatsApp da loja (se disponível)
                        if (controller.selectedProduct.value!.haveWhats)
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.01),
                            child: CircularButton(
                              onPressed: () {
                                controller.whatstoStore();
                              },
                              icon: AppTheme.icons.whatsapp,
                              size: Get.height * 0.03,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Descrição detalhada do produto
            Description(
              width: Get.width * 0.9,
              description: controller.selectedProduct.value!.description,
              fontSize: Get.height * 0.02,
            ),
          ],
        ),
      );
    });
  }
}
