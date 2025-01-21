import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/widgets/menu.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/screens/cart_page.dart';
import 'package:market_finder/screens/store_list/product_list_store_page.dart';
import 'package:market_finder/screens/search_page.dart';
import 'package:market_finder/screens/profile_page.dart';
import 'package:market_finder/widgets/keepalive.widget.dart';

class HomePage extends StatefulWidget {
  final bool isUser; //Variavel que define se é usuario ou loja
  const HomePage({super.key, required this.isUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Criação da tela home, que controla as subpaginas de busca de produtos, perfil e cvarrinho/lista de produtos
class _HomePageState extends State<HomePage> {
  //Controlador das subpaginas
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      body: PageView(
        //Widget que controla as subpaginas
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          // Tela do Perfil do Usuario
          ProfilePage(
            isUser: widget.isUser,
          ),
          // Tela de busca de produto e do produto
          Navigator(
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                  //Define o material para ser usado pelas telas
                  builder: (context) =>
                      //KeepAliveInpede que a tela seja desconstruida ao perder o foco
                      const SearchPage(initialSearchText: ''));
            },
          ),
          //Tela de carrinho/lista de produto conforme o tipo de usuario
          Navigator(
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                  //Define o material para ser usado pelas telas
                  builder: (context) =>
                      //KeepAliveInpede que a tela seja desconstruida ao perder o foco
                      KeepAliveWrapper(
                        child: widget.isUser
                            ? ShoppingCartPage()
                            : ProductListStorePage(),
                      ));
            },
          ),
        ],
      ),
      // Menu de navegação das telas
      bottomNavigationBar: Menu(
        isUser: widget.isUser,
        currentPage: _currentPage,
        pageController: _pageController,
        heigth: Get.height * 0.1,
      ),
    );
  }
}
