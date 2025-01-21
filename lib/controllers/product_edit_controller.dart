import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/models/product.dart';
import 'package:market_finder/models/store.dart';
import 'package:market_finder/services/products_service.dart';

/// Controlador responsável pela lógica da tela de cadastro/edição de produtos.
class CadProductController extends GetxController {
  // Controllers para entrada de texto nos campos
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Serviços e utilitários
  final ProductService productService =
      ProductService(); // Serviço para gerenciar produtos
  final ImagePicker _picker = ImagePicker(); // Picker para selecionar imagens
  final BoxMessage boxMessage = BoxMessage(); // Exibe mensagens para o usuário

  // Chave do formulário para validação
  final formKey = GlobalKey<FormState>();

  // Produto sendo editado/cadastrado
  var product = ProductsInfos(
    storeName: '',
    productValue: '',
    productName: '',
    description: '',
    img: '',
    un: '',
    haveDelivery: false,
    id: '',
    haveEmail: false,
    havePhone: false,
    haveWhats: false,
    phoneNumber: '',
    qnt: 1,
  ).obs;

  late StoreInfos storeInfos; // Informações da loja relacionadas ao produto

  /// Inicializa os valores do produto nos campos
  void startValues() {
    whatsController.text = product.value.phoneNumber;
    nameController.text = product.value.productName;
    descriptionController.text = product.value.description;
    valorController.text = product.value.productValue;

    emailController.text = storeInfos.email;
    phoneController.text = storeInfos.phoneNumber;
    product.value.storeName = storeInfos.fantasiName;
  }

  /// Função para selecionar e carregar uma imagem do dispositivo
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsString();
      product.update((val) {
        val?.img = bytes; // Atualiza o valor da imagem no produto
      });
    }
  }

  /// Atualiza o nome do produto
  void updateProductName(String value) {
    product.update((val) {
      val?.productName = value;
    });
  }

  /// Atualiza o valor do produto, validando a entrada de acordo com regras
  void updateProductValue(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    value = value.replaceFirst(RegExp(r'^0+'), '');
    if (value.isEmpty) {
      value = "0.00";
      updateValue(value);
      valorController.text = product.value.productValue;
    } else if (value.length < 7) {
      print(value);
      if (value.length == 1) {
        value = "0.0$value";
      } else if (value.length == 2) {
        value = '0.$value';
      } else {
        String partUm = value.substring(0, value.length - 2);
        String partDois = value.substring(value.length - 2);
        value = '$partUm.$partDois';
      }
      updateValue(value);
      valorController.text = product.value.productValue;
    } else {
      value = product.value.productValue;
      updateValue(value);
      valorController.text = product.value.productValue;
    }
  }

  void updateValue(String value) {
    product.update((val) {
      val?.productValue = value;
    });
  }

  /// Atualiza a descrição do produto
  void updateDescription(String value) {
    product.update((val) {
      val?.description = value;
    });
  }

  /// Atualiza o número do WhatsApp, removendo caracteres indesejados
  void updateWhatsapp(String value) {
    value = value.replaceAll(RegExp(r'[()-\s]'), '');
    product.update((val) {
      val?.phoneNumber = value;
    });
  }

  /// Atualiza o status de entrega do produto
  void updateHaveDelivery(bool value) {
    product.update((val) {
      val?.haveDelivery = value;
    });
  }

  /// Atualiza o status de exibição do botão WhatsApp
  void updateHaveWhats(bool value) {
    product.update((val) {
      val?.haveWhats = value;
    });
  }

  /// Atualiza o status de exibição do botão Telefone
  void updateHavePhone(bool value) {
    product.update((val) {
      val?.havePhone = value;
    });
  }

  /// Atualiza o status de exibição do botão E-mail
  void updateHaveEmail(bool value) {
    product.update((val) {
      val?.haveEmail = value;
    });
  }

  /// Adiciona ou atualiza um produto no backend
  void addProduct(BuildContext context) async {
    String message;
    String typeFunction;

    if (product.value.id == '') {
      // Novo produto
      message = await productService.createProduct(product.value);
      typeFunction = "cadastrar";
    } else {
      // Atualização de produto existente
      message = await productService.upadateProduct(product.value);
      typeFunction = "atualizar";
    }

    if (context.mounted) {
      if (!message.contains('Erro')) {
        Navigator.pop(context); // Volta para a tela anterior em caso de sucesso
      } else {
        erroMensagem(
          context,
          'Erro ao $typeFunction produto, tente novamente mais tarde',
        );
      }
    }
  }

  /// Exibe mensagem de erro para o usuário
  void erroMensagem(BuildContext context, String text) {
    boxMessage.showMessage(context: context, message: text);
  }

  /// Validação dos campos do formulário
  String? validate(ValidationMode typeValidate, String? text) {
    if (text == null || text.isEmpty) {
      return "Preechimento invalido";
    } else {
      switch (typeValidate) {
        case ValidationMode.text:
          return null;
        case ValidationMode.whats:
          if (!text.isPhoneNumber && product.value.haveWhats) {
            return "Preechimento invalido";
          }
          break;
        case ValidationMode.value:
          String valueTest = text.replaceAll('.', '');
          if (!valueTest.isNumericOnly) {
            return "Preechimento invalido";
          } else if (text.contains('.')) {
            List<String> parseValue = text.split('.');
            if (parseValue.length > 2 || parseValue[1].length > 2) {
              return "Preechimento invalido";
            }
          }
      }
    }
    return null;
  }
}

/// Enum para diferentes tipos de validação
enum ValidationMode {
  value, // Validações numéricas
  text, // Texto genérico
  whats, // Número de telefone/WhatsApp
}
