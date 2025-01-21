import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_circular.dart';
import 'package:market_finder/components/show_img.dart';
import 'package:market_finder/controllers/store_list_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

/// Widget que representa o cartão de um produto na lista de produtos cadastrados.
class ListCardRegister extends GetView<StoreListController> {
  // Índice do produto na lista de produtos.
  final int index;

  const ListCardRegister({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.25, // Altura do cartão.
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Get.width * 0.03), // Borda arredondada.
        color: AppTheme.colors.white, // Cor de fundo.
        boxShadow: [
          BoxShadow(
            color: AppTheme.colors.black
                .withValues(alpha: 0.3), // Sombra com opacidade.
            spreadRadius: Get.width * 0.001,
            blurRadius: Get.width * 0.01,
            offset: const Offset(1, 3), // Offset para posição da sombra.
          ),
        ],
      ),
      // Estrutura do conteúdo do cartão.
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Espaçamento uniforme.
        children: [
          // Linha superior com imagem, informações e botões.
          SizedBox(
            height: Get.height * 0.17,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Distribuição uniforme.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagem do produto.
                SizedBox(
                  width: Get.width * 0.25,
                  child: buildImage(
                    controller.productsCards[index].img,
                    Get.width * 0.25,
                    Get.height * 0.1,
                  ),
                ),
                // Nome e descrição do produto.
                SizedBox(
                  width: Get.width * 0.45,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Alinhamento à esquerda.
                    children: [
                      Text(
                        controller.productsCards[index]
                            .productName, // Nome do produto.
                        style: TextStyle(
                          fontFamily: AppTheme.fonts.primaryFont,
                          fontSize: Get.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.12,
                        child: SingleChildScrollView(
                          child: Text(
                            controller.productsCards[index]
                                .description, // Descrição do produto.
                            style: TextStyle(
                              fontFamily: AppTheme.fonts.primaryFont,
                              fontSize: Get.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Botões de informações de contato.
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (controller.productsCards[index].haveEmail)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.005,
                        ),
                        child: CircularButton(
                          onPressed: () {
                            controller.showMessage(
                                'Email cadastrado ${controller.storeInfos.email}');
                          },
                          icon: AppTheme.icons.letter,
                          size: Get.height * 0.02,
                        ),
                      ),
                    if (controller.productsCards[index].haveWhats)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.005,
                        ),
                        child: CircularButton(
                          onPressed: () {
                            controller.showMessage(
                                'Whatsapp cadastrado ${controller.productsCards[index].phoneNumber}');
                          },
                          icon: AppTheme.icons.whatsapp,
                          size: Get.height * 0.02,
                        ),
                      ),
                    if (controller.productsCards[index].havePhone)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.005,
                        ),
                        child: CircularButton(
                          onPressed: () {
                            controller.showMessage(
                                'Telefone cadastrado ${controller.storeInfos.phoneNumber}');
                          },
                          icon: AppTheme.icons.phone,
                          size: Get.height * 0.02,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Linha inferior com preço, informações de entrega e ações.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Preço por unidade e ícone de entrega.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$${controller.productsCards[index].productValue}\\un', // Valor unitário.
                      style: TextStyle(
                        fontFamily: AppTheme.fonts.primaryFont,
                        fontSize: Get.height * 0.04,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Get.width * 0.02),
                      child: controller.productsCards[index].haveDelivery
                          ? Icon(
                              AppTheme.icons.delivery, // Ícone de entrega.
                              size: Get.width * 0.07,
                            )
                          : null,
                    ),
                  ],
                ),
                // Botões de edição e exclusão do produto.
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.015),
                      child: CircularButton(
                        onPressed: () {
                          controller.openEditProductView(
                              context, index); // Edita o produto.
                        },
                        icon: AppTheme.icons.edit,
                        size: Get.width * 0.06,
                      ),
                    ),
                    CircularButton(
                      onPressed: () {
                        controller.showConfirmDeleteProduct(
                            context, index); // Exclui o produto.
                      },
                      icon: AppTheme.icons.bin,
                      size: Get.width * 0.06,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
