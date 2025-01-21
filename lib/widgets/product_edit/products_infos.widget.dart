import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_circular.dart';
import 'package:market_finder/components/descriptions.dart';
import 'package:market_finder/components/price.dart';
import 'package:market_finder/components/show_img.dart';
import 'package:market_finder/controllers/product_edit_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

/// Widget para visualização e informações do produto em cadastro/edição
class ProductsInfosCadView extends GetView<CadProductController> {
  const ProductsInfosCadView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Nome do produto e botão de voltar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Botão para voltar à tela anterior
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Volta para a tela anterior
                },
              ),
              // Nome do produto
              Obx(() => Text(
                    controller.product.value.productName,
                    style: TextStyle(
                      fontSize: Get.height * 0.05,
                      fontFamily: AppTheme.fonts.primaryFont,
                    ),
                  )),
            ],
          ),

          /// Imagem do produto e informações adicionais
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Imagem do produto
                Obx(() => SizedBox(
                      width: Get.width * 0.35,
                      child: controller.product.value.img.isEmpty
                          ? const SizedBox.shrink() // Caso não haja imagem
                          : buildImage(
                              controller.product.value.img,
                              Get.width * 0.4,
                              Get.height * 0.1,
                            ),
                    )),
                // Informações adicionais do produto
                SizedBox(
                  width: Get.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nome da loja
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                                controller.product.value.storeName,
                                style: TextStyle(
                                  fontSize: Get.height * 0.03,
                                  fontFamily: AppTheme.fonts.primaryFont,
                                ),
                              )),
                          // Botão fictício (placeholder)
                          CircularButton(
                            onPressed: () {}, // Ação não implementada
                            icon: AppTheme.icons.cart,
                            size: Get.height * 0.03,
                          ),
                        ],
                      ),
                      // Preço do produto
                      Obx(() => Price(
                            productValue: controller.product.value.productValue,
                            measurUnity: controller.product.value.un,
                            width: Get.width * 0.5,
                            height: Get.height * 0.1,
                            fontSize: Get.height * 0.025,
                            fontFamily: AppTheme.fonts.primaryFont,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Informações adicionais: entrega e ações
          Padding(
            padding: EdgeInsets.only(bottom: Get.height * 0.02),
            child: SizedBox(
              width: Get.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicação de entrega
                  Row(
                    children: [
                      Obx(
                        () => controller.product.value.haveDelivery
                            ? Icon(
                                AppTheme.icons.delivery,
                                size: Get.height * 0.04,
                              )
                            : const SizedBox.shrink(),
                      ),
                      // Placeholder para distância até a loja
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.02),
                        child: Text(
                          '????m', // Informação fictícia
                          style: TextStyle(
                            fontFamily: AppTheme.fonts.primaryFont,
                            fontSize: Get.height * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Botões de ações: GPS, telefone, email, WhatsApp
                  Row(
                    children: [
                      CircularButton(
                        onPressed: () {}, // Ação não implementada
                        icon: AppTheme.icons.gps,
                        size: Get.height * 0.03,
                      ),
                      Obx(
                        () => controller.product.value.havePhone
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.01),
                                child: CircularButton(
                                  onPressed: () {}, // Ação não implementada
                                  icon: AppTheme.icons.phone,
                                  size: Get.height * 0.03,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Obx(
                        () => controller.product.value.haveEmail
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.01),
                                child: CircularButton(
                                  onPressed: () {}, // Ação não implementada
                                  icon: AppTheme.icons.letter,
                                  size: Get.height * 0.03,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Obx(
                        () => controller.product.value.haveWhats
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.01),
                                child: CircularButton(
                                  onPressed: () {}, // Ação não implementada
                                  icon: AppTheme.icons.whatsapp,
                                  size: Get.height * 0.03,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// Descrição do produto
          SizedBox(
            width: Get.width * 0.9,
            child: Obx(() => Description(
                  width: Get.width * 0.9,
                  description: controller.product.value.description,
                  fontSize: Get.height * 0.02,
                )),
          ),
        ],
      ),
    );
  }
}
