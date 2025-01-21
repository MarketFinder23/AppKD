import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_circular.dart';
import 'package:market_finder/controllers/cart_controller.dart';
import 'package:market_finder/widgets/cart_page/products_card_cart.widget.dart';
import 'package:market_finder/models/theme/theme.dart';

class CardStoreCart extends GetView<CartController> {
  // Variáveis para tamanho e índice da loja
  final double width;
  final double heigth;
  final int indexStore;

  const CardStoreCart({
    super.key,
    required this.width,
    required this.heigth,
    required this.indexStore,
  });

  @override
  Widget build(BuildContext context) {
    // Criação do cartão do carrinho de compras
    return Obx(() {
      return Container(
        width: width,
        height:
            controller.cartCards[indexStore].isOpen.value ? heigth * 4 : heigth,
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
        child: Column(
          children: [
            // Cabeçalho do cartão
            SizedBox(
              height: heigth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: heigth * 0.08,
                  horizontal: width * 0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nome da loja
                        Text(
                          controller.cartCards[indexStore].storeName,
                          style: TextStyle(
                            fontSize: heigth * 0.2,
                            fontFamily: AppTheme.fonts.primaryFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Valor total do carrinho
                        Text(
                          "R\$${controller.cartCards[indexStore].totalStore}",
                          style: TextStyle(
                            fontSize: heigth * 0.2,
                            fontFamily: AppTheme.fonts.primaryFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Botões de contato com a loja
                        SizedBox(
                          width: width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircularButton(
                                onPressed: () {
                                  controller.maptoStore(
                                      controller.location[indexStore]);
                                },
                                icon: AppTheme.icons.gps,
                                size: width * 0.06,
                              ),
                              CircularButton(
                                onPressed: () {
                                  controller.calltoStore(
                                      controller.cartCards[indexStore].phone);
                                },
                                icon: AppTheme.icons.phone,
                                size: width * 0.06,
                              ),
                              CircularButton(
                                onPressed: () {
                                  controller.emailtoStore(
                                      controller.cartCards[indexStore].email);
                                },
                                icon: AppTheme.icons.letter,
                                size: width * 0.06,
                              ),
                              CircularButton(
                                onPressed: () {
                                  controller.whatstoStore(
                                      controller.cartCards[indexStore].whats);
                                },
                                icon: AppTheme.icons.whatsapp,
                                size: width * 0.06,
                              ),
                            ],
                          ),
                        ),
                        // Ícones adicionais e botão de expandir/recolher
                        SizedBox(
                          width: width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              controller.cartCards[indexStore].haveDelivery
                                  ? Icon(AppTheme.icons.delivery)
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  controller.distance.length > indexStore
                                      ? controller.distance[indexStore]
                                      : 'Carregando...',
                                  style: TextStyle(
                                    fontSize: heigth * 0.26 * 0.8,
                                    fontFamily: AppTheme.fonts.primaryFont,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.switchSizeCard(indexStore);
                                },
                                icon: Icon(
                                  controller.cartCards[indexStore].isOpen.value
                                      ? AppTheme.icons.arrowUp
                                      : AppTheme.icons.arrowDown,
                                  size: heigth * 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Lista de produtos se o cartão estiver expandido
            if (controller.cartCards[indexStore].isOpen.value)
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cartCards[indexStore].products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: heigth * 0.07,
                        horizontal: width * 0.02,
                      ),
                      child: BuyCardCart(
                        indexStore: indexStore,
                        index: index,
                        width: width * 0.95,
                        heigth: heigth * 0.9,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}
