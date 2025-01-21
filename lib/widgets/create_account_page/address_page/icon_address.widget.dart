import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

// Widget para exibir um ícone na página de endereço
class IconCaAddress extends GetView<CreateAccountController> {
  const IconCaAddress({super.key});

  @override
  Widget build(BuildContext context) {
    // Determina qual ícone exibir com base no tipo de usuário (usuário ou loja)
    return Icon(
      controller.isUser
          ? AppTheme.icons.house // Ícone de casa para usuário comum
          : AppTheme
              .icons.store, // Ícone de loja para estabelecimentos comerciais
      size: 35, // Tamanho fixo do ícone
    );
  }
}
