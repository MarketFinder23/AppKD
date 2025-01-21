import 'package:flutter/material.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/models/theme/theme.dart';

// Tela de confirmação que aparece com uma mensagem e botões para confirmar ou rejeitar
class ShowDialog extends StatelessWidget {
  // Callback para ser executado ao confirmar a ação
  final VoidCallback onConfirm;

  // Texto do título da mensagem
  final String title;

  // Texto dos botões (negativo e positivo)
  final String textNegative;
  final String textPositive;

  // Dimensões para configurar altura e largura
  final double height;
  final double width;

  const ShowDialog({
    super.key,
    required this.onConfirm,
    required this.height,
    required this.width,
    required this.title,
    required this.textNegative,
    required this.textPositive,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.colors.white, // Cor de fundo do AlertDialog
      shape: RoundedRectangleBorder(
        // Define bordas arredondadas para o diálogo
        borderRadius: BorderRadius.circular(width * 0.1),
      ),
      // Texto da mensagem exibida no diálogo
      title: Text(
        title,
        textAlign: TextAlign.center, // Centraliza o texto
        style: TextStyle(
          fontFamily: AppTheme.fonts.primaryFont, // Fonte personalizada
          fontSize:
              height * 0.3, // Tamanho da fonte baseado na altura fornecida
        ),
      ),
      // Padding do conteúdo do AlertDialog
      contentPadding: EdgeInsets.symmetric(
          vertical: width * 0.05, horizontal: width * 0.05),
      actions: <Widget>[
        // Row que contém os botões de ação (SIM e NÃO)
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // Espaçamento uniforme entre os botões
          children: [
            // Botão de ação negativa
            TextButtonRounded(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo ao pressionar
              },
              text: textNegative, // Texto do botão
              style: ButtonStyleType.negative, // Estilo definido para o botão
              height: height * 0.5,
              width: width * 0.4, // Ajusta a largura do botão
            ),
            // Botão de ação positiva
            TextButtonRounded(
              onPressed: () {
                onConfirm(); // Executa a ação de confirmação fornecida
                Navigator.of(context).pop(); // Fecha o diálogo ao pressionar
              },
              text: textPositive, // Texto do botão
              style: ButtonStyleType.positive, // Estilo definido para o botão
              height: height * 0.5,
              width: width * 0.4, // Ajusta a largura do botão
            ),
          ],
        )
      ],
    );
  }
}
