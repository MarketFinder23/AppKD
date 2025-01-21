import 'package:flutter/material.dart';
import 'package:market_finder/widgets/create_account_page/text_ca_page.widget.dart';

// Widget que exibe um título e uma descrição organizados em uma coluna
class TitleDescription extends StatelessWidget {
  // Título principal
  final String title;
  // Descrição adicional
  final String description;
  // Tamanho base da fonte
  final double fontSize;

  const TitleDescription({
    super.key,
    required this.title,
    required this.description,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Exibe o título usando o widget `TextCaPage`
        TextCaPage(
          text: title, // Define o texto do título
          fontSize: fontSize, // Define o tamanho da fonte do título
        ),
        // Exibe a descrição com um tamanho de fonte menor
        TextCaPage(
          text: description, // Define o texto da descrição
          fontSize: fontSize * 0.6, // Tamanho da fonte reduzido (60% do título)
        ),
      ],
    );
  }
}
