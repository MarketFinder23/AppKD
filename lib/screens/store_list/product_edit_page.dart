import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/product_edit_controller.dart';
import 'package:market_finder/models/product.dart';
import 'package:market_finder/models/store.dart';
import 'package:market_finder/widgets/product_edit/products_infos.widget.dart';
import 'package:market_finder/widgets/product_edit/textfilds_products.widget.dart';

/// Tela de Cadastro/Edição de Produto
class ProductCadPage extends StatelessWidget {
  /// Dados do produto a serem editados ou cadastrados
  final ProductsInfos productsInfos;

  /// Informações da loja associada ao produto
  final StoreInfos storeInfos;

  /// Construtor que inicializa os dados do produto e da loja
  ProductCadPage({
    super.key,
    required this.productsInfos,
    required this.storeInfos,
  }) {
    // Inicializa o controlador responsável pelo cadastro/edição do produto
    final CadProductController controller = Get.put(CadProductController());

    // Define os valores iniciais no controlador
    controller.product.value = productsInfos;
    controller.storeInfos = storeInfos;
    controller.startValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.06),
        child: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: const Column(
              children: [
                ProductsInfosCadView(), // Visualização de informações básicas do produto
                TextEditProducts(), // Campos para edição do produto
              ],
            ),
          ),
        ),
      ),
    );
  }
}
