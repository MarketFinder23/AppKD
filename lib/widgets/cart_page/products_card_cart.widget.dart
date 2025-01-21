import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_circular.dart';
import 'package:market_finder/components/dropdown_number.dart';
import 'package:market_finder/components/show_img.dart';
import 'package:market_finder/controllers/cart_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

class BuyCardCart extends GetView<CartController> {
  // Configuração de tamanho
  final double width;
  final double heigth;

  // Índices para identificar o produto e a loja
  final int index;
  final int indexStore;

  const BuyCardCart({
    super.key,
    required this.index,
    required this.indexStore,
    required this.width,
    required this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: width,
        height: heigth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(heigth * 0.15),
          color: AppTheme.colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        // Informações do cartão
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Exibição da imagem do produto
            SizedBox(
              width: width * 0.2,
              child: buildImage(
                controller.cartCards[indexStore].products[index].img,
                width * 0.2,
                Get.height * 0.1,
              ),
            ),
            // Detalhes do produto
            SizedBox(
              width: width * 0.7,
              height: heigth * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nome do produto
                      Text(
                        controller
                            .cartCards[indexStore].products[index].productName,
                        style: TextStyle(
                          fontFamily: AppTheme.fonts.primaryFont,
                          fontSize: heigth * 0.2,
                        ),
                      ),
                      // Preço unitário do produto
                      Text(
                        'R\$${controller.cartCards[indexStore].products[index].productValue} /un',
                        style: TextStyle(
                          fontFamily: AppTheme.fonts.primaryFont,
                          fontSize: heigth * 0.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Seleção de quantidade
                      DropdownListNumber(
                        valueDefault: controller
                            .cartCards[indexStore].products[index].qnt.value,
                        onChangedNumber: (value) async {
                          await controller.attQnt(
                              context, indexStore, index, value);
                        },
                        qntMax: 200,
                        un: 'Un',
                        height: heigth * 0.4,
                        width: width * 0.25,
                      ),
                      Row(
                        children: [
                          // Valor total baseado na quantidade
                          Text(
                            (controller.cartCards[indexStore].products[index]
                                        .qnt.value *
                                    double.parse(controller
                                        .cartCards[indexStore]
                                        .products[index]
                                        .productValue))
                                .toStringAsFixed(2),
                            style: TextStyle(
                              fontFamily: AppTheme.fonts.primaryFont,
                              fontSize: heigth * 0.25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.05),
                            // Botão de excluir produto
                            child: SizedBox(
                              width: width * 0.12,
                              height: width * 0.12,
                              child: CircularButton(
                                onPressed: () {
                                  controller.showConfirmaDeleteDialog(
                                      context, indexStore, index);
                                },
                                icon: AppTheme.icons.bin,
                                size: width * 0.05,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
