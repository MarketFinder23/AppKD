import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class Menu extends StatefulWidget {
  // --------- Varivaeis a serem passadas por parametro --------- \\
  final bool isUser;
  final int currentPage;
  final PageController pageController;
  final double heigth;
  // ------------------------------------------------------------ \\
  const Menu({
    super.key,
    required this.isUser,
    required this.currentPage,
    required this.pageController,
    required this.heigth,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // --- Variaveis com valores fixos --- \\
  late double iconSize;
  late double fontSize;
  final int anitionTime = 100;
  // ----------------------------------- \\+
  // --- Inicialização das variaveis --- //
  @override
  void initState() {
    super.initState();
    iconSize = widget.heigth * 0.4;
    fontSize = widget.heigth * 0.01;
  }

  @override
  Widget build(BuildContext context) {
    // ---- Widget de menu ----\\
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(size: iconSize),
      selectedItemColor: AppTheme.colors.primary,
      unselectedItemColor: AppTheme.colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentPage,
      backgroundColor: AppTheme.colors.white,
      // --- Itens do Menu --- \\
      items: [
        // Cada item tem um icone e um texto abaixo desse icone \\
        BottomNavigationBarItem(
          icon: Icon(AppTheme.icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppTheme.icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(widget.isUser ? AppTheme.icons.cart : AppTheme.icons.edit),
          label: widget.isUser ? 'Carrinho' : 'Cadastros',
        ),
      ],
      // --------------------- \\
      onTap: (page) {
        widget.pageController.animateToPage(
          page,
          duration: Duration(milliseconds: anitionTime),
          curve: Curves.linear,
        );
      },
    );
    // ------------------------\\
  }
}
