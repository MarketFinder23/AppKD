import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/box_message.dart';
import 'package:market_finder/screens/home.dart';
import 'package:market_finder/screens/login_page.dart';
import 'package:market_finder/services/login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  // Controladores para os campos de texto e formulário
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Serviço para realizar operações de login
  final LoginServices loginServices = LoginServices();

  // Componente de mensagens de alerta
  final BoxMessage noticeBox = BoxMessage();

  // Variáveis reativas para controle de validação
  bool emailValid = true;
  bool passwordValid = true;

  // Variavel para o controle de login
  RxBool tryLogin = false.obs;

  // Mensagens de erro para validação
  final String emailInconrrectMessage =
      'Email não cadastrado, tente novamente!';
  final String emailInvalidMessage = 'Este não é um email valido!';
  final String passwordIncorrectMessage = 'Senha incorreta, tente novamente!';
  final String passwordInvalidMessage =
      'Sua senha deve conter pelo menos 8 dígitos';

  @override
  void onInit() {
    super.onInit();
    // Valida automaticamente o login ao iniciar
    loginValidate();
  }

  // Validação automática do login usando informações armazenadas em cache
  void loginValidate() async {
    bool? isUser;
    final storage = await SharedPreferences.getInstance();
    isUser = storage.getBool('isUser'); // Verifica se há um usuário salvo

    if (isUser != null) {
      final email = storage.getString('email');
      final password = storage.getString('password');
      if (email != null && password != null) {
        final response = await loginServices.tryLogin(email, password);
        if (response['message'] == 'successfully') {
          // Navega para a tela principal se o login for bem-sucedido
          isUser = response['isUser'];
          Get.offAll(() => HomePage(isUser: isUser!));
        } else {
          Get.offAll(() => const LoginPage());
        }
      } else {
        Get.offAll(() => const LoginPage());
      }
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  // Validação do campo de senha
  String? passwordValidate(String? text) {
    if (!passwordValid) {
      return passwordIncorrectMessage;
    }
    if (text == null || text.length < 8) {
      return passwordInvalidMessage;
    }
    return null;
  }

  // Validação do campo de email
  String? emailValidate(String? text) {
    if (!emailValid) {
      return emailInconrrectMessage;
    }
    if (text == null || text.isEmpty || !text.isEmail) {
      return emailInvalidMessage;
    }
    return null;
  }

  // Função para tentar logar usando a API
  void tryToLogin(BuildContext context) async {
    tryLogin.value = true;
    final storage = await SharedPreferences.getInstance();

    if (formKey.currentState?.validate() ?? false) {
      // Se os campos são válidos, tenta logar
      final response = await loginServices.tryLogin(
        emailController.text,
        passwordController.text,
      );

      final message = response['message'];
      final bool? isUser = response['isUser'];
      if (message == 'emailError') {
        emailValid = false;
        formKey.currentState!.validate();
      } else if (message == 'passwordError') {
        passwordValid = false;
        formKey.currentState!.validate();
      } else if (message == 'successfully') {
        // Armazena informações de login em cache
        storage.setBool('isUser', isUser!);
        storage.setString('email', emailController.text);
        storage.setString('password', passwordController.text);

        if (context.mounted) {
          // Navega para a tela principal se o login for bem-sucedido
          Get.offAll(() => HomePage(isUser: isUser));
        }
      } else {
        // Exibe mensagem de erro caso algo dê errado
        if (context.mounted) {
          noticeBox.showMessage(
              context: context, message: 'Erro de comunicação: $message');
        }
      }
    }
    tryLogin.value = false;
  }

  // Reseta a validação ao modificar os campos de entrada
  void resetValidation() {
    emailValid = true;
    passwordValid = true;
  }

  // Função para navegação para outra tela
  void navegationPage(BuildContext context, String page) {
    Navigator.pushNamed(context, page);
  }
}
