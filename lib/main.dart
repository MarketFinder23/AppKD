import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/screens/create_account/address_ca_page.dart';
import 'package:market_finder/screens/create_account/contact_ca_page.dart';
import 'package:market_finder/screens/create_account/finish_ca_page.dart';
import 'package:market_finder/screens/create_account/legal_ca_page.dart';
import 'package:market_finder/screens/create_account/name_ca_page.dart';
import 'package:market_finder/screens/create_account/password_ca_page.dart';
import 'package:market_finder/screens/create_account/select_user_ca_page.dart';
import 'package:market_finder/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garantir que o Flutter esteja inicializado
  runApp(const MyApp()); //Chama o app em si
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Inicializa o LoginPageController logo que o app inicia
    Get.put(LoginPageController());

    return GetMaterialApp(
      // Construtor geral do aplicativo
      routes: {
        '/login_page': (context) => const LoginPage(),
        // Rotas das telas de criar conta
        '/create_account/select_user': (context) => const CaSelectUserPage(),
        '/create_account/name': (context) => const CaNamePage(),
        '/create_account/contact': (context) => const CaContactPage(),
        '/create_account/address': (context) => const CaAddressPage(),
        '/create_account/legal': (context) => const CaLegalPage(),
        '/create_account/password': (context) => const CaPasswordPage(),
        '/create_account/finish': (context) => const CaFinishPage(),
      },
      theme: ThemeData(
          primaryColor: AppTheme.colors.primary,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppTheme.colors.primary,
            secondary: AppTheme.colors.black,
          )),
      // Abre um Loading na tela até o controller da tela de Login validar login e redirecionar
      home: Scaffold(
        body: Container(
          color: AppTheme.colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
