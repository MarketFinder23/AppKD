import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:market_finder/models/address.dart';
import 'package:market_finder/models/store.dart';
import 'package:market_finder/models/user.dart';
import 'package:market_finder/screens/home.dart';
import 'package:market_finder/services/address_service.dart';
import 'package:market_finder/services/store_service.dart';
import '../services/user_service.dart';
import '../components/box_message.dart';

class CreateAccountController extends GetxController {
  // Controladores de texto para capturar dados da interface do usuário
  final TextEditingController nameController = TextEditingController();
  final TextEditingController socialNameController = TextEditingController();
  final TextEditingController fantasiNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  // Chaves de formulário para validar e salvar dados em cada etapa
  final GlobalKey<FormState> formKeyCaName = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCaContact = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCaAddress = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCaLegal = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCaPassword = GlobalKey<FormState>();

  // Objetos que armazenam as informações do usuário, loja e endereço
  final UserInfos user = UserInfos(
      name: '',
      phoneNumber: '',
      email: '',
      cpf: '',
      password: '',
      addressID: '');
  final StoreInfos store = StoreInfos(
      fantasiName: '',
      corporateReason: '',
      phoneNumber: '',
      whatsapp: '',
      email: '',
      cnpj: '',
      password: '',
      addressID: '');
  final AddressInfos address = AddressInfos(
    cep: '',
    city: '',
    neighborhood: '',
    street: '',
    number: '',
    complement: '',
    id: '',
  );

  // Variável para identificar o tipo de conta (usuário ou loja)
  bool isUser = true;

  // Variáveis reativas para controle de estado
  var error = false.obs; // Controle de erro
  var isConecting = false.obs; // Estado de conexão (carregamento)

  // Serviços para comunicação com a API
  final UserService userService = UserService();
  final StoreService storeService = StoreService();
  final AddressService addressService = AddressService();

  // Caixa de mensagem para erros ou avisos
  final BoxMessage errorBox = BoxMessage();

  // Mensagens de erro para validação de campos
  final String emptyEM = "Aqui não pode ficar vazio!!!";
  final String emailEM = "Esse e-mail tá meio errado!!!";
  final String phoneEM = "O telefone tá errado, tenta de novo";
  final String cepEM = "Esse lugar não existe em!!!";
  final String numberEM = "Só pode número meu chapa!!!";
  final String cpfEM = "Um CPF decente tem 11 números!!!";
  final String cnpjEM = "Um CNPJ deve conter 14 números!!!";
  final String confirmPassEM = "As senhas não batem!!!";
  final String passwordEM = "A senha deve ter pelo menos 8 caracteres!!!";

  // Define o tipo de usuário (usuário ou loja)
  void typeUser(bool user) {
    isUser = user;
  }

  // Navega para a próxima tela no fluxo de criação de conta
  void navigateToNextScreen(BuildContext context, String nextScreen) {
    Navigator.of(context).pushNamed('/create_account/$nextScreen');
  }

  // Salva o formulário atual e navega para a próxima tela
  void saveForm(
      BuildContext context, GlobalKey<FormState> formKey, String nextScreen) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      navigateToNextScreen(context, nextScreen);
    }
  }

  // Cria o endereço do usuário ou loja
  Future<bool> createAddress() async {
    final response = await addressService.createAddress(address);
    if (response['message'] == 'successfully') {
      address.id = response['id'].toString(); // Atualiza o ID do endereço
      return true;
    }
    return false;
  }

  // Cria o usuário ou a loja com base no tipo selecionado
  Future<bool> createUserOrStore() async {
    if (isUser) {
      user.addressID = address.id; // Vincula o ID do endereço ao usuário
      return await userService.createUser(user) == 'successfully';
    } else {
      store.addressID = address.id; // Vincula o ID do endereço à loja
      return await storeService.createStore(store) == 'successfully';
    }
  }

  // Processo completo de criação de conta
  void createAcount(context) async {
    isConecting.value = true; // Inicia o carregamento

    if (await createAddress()) {
      if (await createUserOrStore()) {
        Get.offAll(() => HomePage(isUser: isUser)); // Navega para a home
      } else {
        handleError(context, '/create_account/name'); // Redireciona para nome
      }
    } else {
      handleError(
          context, '/create_account/address'); // Redireciona para endereço
    }

    isConecting.value = false; // Finaliza o carregamento
  }

  // Lida com erros e redireciona para a rota correspondente
  void handleError(BuildContext context, String route) {
    error.value = true;
    Navigator.of(context).popUntil((r) => r.settings.name == route);
  }

  // Exibe a caixa de erro
  void showErrorBox(BuildContext context) {
    errorBox.showMessage(context: context, message: 'Texto');
    error.value = false;
  }

  // Função genérica para validação de campos
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
      ValidationMode.cnpj: () => text.length == 18 ? null : cnpjEM,
      ValidationMode.password: () => text.length >= 8 ? null : passwordEM,
      ValidationMode.confirmPassword: () =>
          text == passwordController.text ? null : confirmPassEM,
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
  password,
  confirmPassword,
  text,
}
