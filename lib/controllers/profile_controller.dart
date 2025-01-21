import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/models/address.dart';
import 'package:market_finder/models/store.dart';
import 'package:market_finder/models/user.dart';
import 'package:market_finder/screens/login_page.dart';
import 'package:market_finder/services/address_service.dart';
import 'package:market_finder/services/store_service.dart';
import 'package:market_finder/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final bool isUser;

  // Construtor que recebe isUser para diferenciar entre usuário e loja
  ProfileController({required this.isUser});

  // Controllers dos campos de texto da página
  final TextEditingController nameController = TextEditingController();
  final TextEditingController razaoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();
  final TextEditingController docController = TextEditingController();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController naibController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController compController = TextEditingController();

  final GlobalKey<FormState> formAddresKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formInfosKey = GlobalKey<FormState>();

  // Serviços utilizados pela página
  final AddressService addressService = AddressService();
  final UserService userService = UserService();
  final StoreService storeService = StoreService();

  // Caixa de mensagens para feedback ao usuário
  final BoxMessage boxMessage = BoxMessage();

  // Controle de estado da página
  var infosSelected = true.obs; // Alterna entre informações pessoais e endereço
  var isLoading = true.obs; // Indica se os dados estão carregando

  // Mensagens de erro para validação de campos
  final String emptyEM = "Este campo não pode ficar vazio.";
  final String emailEM = "E-mail inválido.";
  final String phoneEM = "Número de telefone inválido.";
  final String cepEM = "CEP inválido.";
  final String numberEM = "Insira apenas números.";
  final String cpfEM = "CPF deve conter 11 dígitos.";
  final String cnpjEM = "CNPJ deve conter 14 dígitos.";

  var nameUser = ''.obs;

  // Informações do perfil e endereço recuperadas do cache ou backend
  late var storeInfos = StoreInfos(
    fantasiName: '',
    corporateReason: '',
    phoneNumber: '',
    whatsapp: '',
    email: '',
    cnpj: '',
    password: '',
    addressID: '',
  ).obs;

  late var userInfos = UserInfos(
    name: '',
    phoneNumber: '',
    email: '',
    cpf: '',
    password: '',
    addressID: '',
  ).obs;

  late var addresInfos = AddressInfos(
    cep: '',
    city: '',
    neighborhood: '',
    street: '',
    number: '',
    complement: '',
    id: '',
  ).obs;

  // Inicialização do controlador
  @override
  void onInit() {
    super.onInit();
    getDatas(Get.context!);
  }

  // Atualiza informações no banco de dados
  Future<void> attInfos() async {
    isLoading.value = true;
    BuildContext? context = Get.context;
    String resultAddress = '', resultInfos = '', message;

    // Verifica qual formulário está selecionado
    if (!infosSelected.value) {
      // Valida o formulário de endereço
      if (!formAddresKey.currentState!.validate()) {
        isLoading.value = false;
        boxMessage.showMessage(
          context: context!,
          message: "Por favor, corrija os erros no formulário de endereço.",
        );
        return;
      }

      // Atualiza o endereço
      resultAddress = await addressService.upadateaddress(addresInfos.value);
      message = resultAddress == 'successfully'
          ? 'Endereço salvo com sucesso.'
          : 'Erro ao atualizar endereço.';
    } else {
      // Valida o formulário de informações
      if (!formInfosKey.currentState!.validate()) {
        isLoading.value = false;
        boxMessage.showMessage(
          context: context!,
          message: "Por favor, corrija os erros no formulário de informações.",
        );
        return;
      }

      // Atualiza as informações de usuário ou loja
      resultInfos = isUser
          ? await userService.upadateUser(userInfos.value)
          : await storeService.upadateStore(storeInfos.value);
      message = resultInfos == 'successfully'
          ? 'Informações atualizadas com sucesso.'
          : 'Erro ao atualizar informações.';
    }

    // Exibe mensagem de feedback
    if (context!.mounted) {
      boxMessage.showMessage(context: context, message: message);
    }

    isLoading.value = false;
  }

  // Recupera os dados do cache ou backend
  Future<void> getDatas(BuildContext context) async {
    isLoading.value = true;
    addresInfos.value = await addressService.getAddress();
    if (addresInfos.value.street.isEmpty) {
      if (context.mounted) {
        boxMessage.showMessage(
            context: context, message: 'Erro ao carregar endereço.');
      }
    } else {
      attAddressTexts();
      if (isUser) {
        userInfos.value = await userService.getUser();
        if (userInfos.value.name.isEmpty) {
          if (context.mounted) {
            boxMessage.showMessage(
                context: context, message: 'Erro ao carregar informações.');
          }
        } else {
          attUserTexts();
          isLoading.value = false;
        }
      } else {
        storeInfos.value = await storeService.getStore();
        if (storeInfos.value.fantasiName.isEmpty) {
          if (context.mounted) {
            boxMessage.showMessage(
                context: context, message: 'Erro ao carregar informações.');
          }
        } else {
          attStoreTexts();
          isLoading.value = false;
        }
      }
    }
  }

  // Atualiza os campos de texto com os valores do endereço
  void attAddressTexts() {
    cityController.text = addresInfos.value.city;
    naibController.text = addresInfos.value.neighborhood;
    cepController.text = addresInfos.value.cep;
    streetController.text = addresInfos.value.street;
    numController.text = addresInfos.value.number;
    compController.text = addresInfos.value.complement;
  }

  // Atualiza os campos de texto com os valores do usuário
  void attUserTexts() {
    nameController.text = userInfos.value.name;
    emailController.text = userInfos.value.email;
    whatsController.text = userInfos.value.phoneNumber;
    docController.text = userInfos.value.cpf;

    nameUser.value = userInfos.value.name;
  }

  // Atualiza os campos de texto com os valores da loja
  void attStoreTexts() {
    nameController.text = storeInfos.value.fantasiName;
    razaoController.text = storeInfos.value.corporateReason;
    emailController.text = storeInfos.value.email;
    phoneController.text = storeInfos.value.phoneNumber;
    whatsController.text = storeInfos.value.whatsapp;
    docController.text = storeInfos.value.cnpj;

    nameUser.value = storeInfos.value.fantasiName;
  }

  // Realiza logout e retorna para a tela de login
  Future<void> logout() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
    Get.offAll(() => const LoginPage());
  }

  // Alterna entre as telas de informações pessoais e endereço
  void toggleInfosSelected() {
    infosSelected.value = !infosSelected.value;
  }

  // Validação genérica de campos com base no tipo
  String? validate(ValidationMode typeValidate, String? text) {
    if (text == null || text.isEmpty) {
      return emptyEM;
    }

    final validators = {
      ValidationMode.email: () => text.isEmail ? null : emailEM,
      ValidationMode.phone: () => text.isPhoneNumber ? null : phoneEM,
      ValidationMode.cep: () => text.length == 9 ? null : cepEM,
      ValidationMode.number: () => text.isNumericOnly ? null : numberEM,
      ValidationMode.cpf: () => text.length == 14 ? null : cpfEM,
      ValidationMode.cnpj: () => text.length == 14 ? null : cnpjEM,
      ValidationMode.text: () => null,
    };
    return validators[typeValidate]?.call();
  }
}

// Enum para definir os tipos de validação disponíveis
enum ValidationMode {
  email,
  phone,
  cep,
  number,
  cpf,
  cnpj,
  text,
}
