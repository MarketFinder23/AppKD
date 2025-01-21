import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  // Variáveis a serem passadas por parâmetro
  final double width; // Largura do widget
  final double height; // Altura do widget
  final double fontSize; // Tamanho da fonte para o texto
  final String productValue; // Valor do produto (em formato de string)
  final String measurUnity; // Unidade de medida associada ao produto
  final String fontFamily; // Família de fontes a ser usada

  // Construtor do widget
  const Price({
    super.key,
    required this.productValue,
    required this.measurUnity,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    // Separando o valor do parâmetro em duas Strings: reais e centavos
    final List<String> parseValue = productValue.split('.');
    final String real = parseValue[0].length == 1
        ? '0${parseValue[0]}' // Adiciona zero à esquerda se o valor for de um dígito
        : parseValue[0]; // Parte inteira do valor
    String cents = (parseValue.length > 1)
        ? parseValue[1].padRight(2, '0') // Completa com zeros se necessário
        : '00'; // Parte decimal (centavos) padronizada com dois dígitos
    // Limita os centavos a no máximo dois dígitos
    cents = cents.substring(0, 2);

    // Ajusta o tamanho da fonte do valor real com base no número de caracteres
    double fontSizeReal = (real.length > 5)
        ? fontSize * 1.4
        : (real.length > 4)
            ? fontSize * 1.7
            : (real.length > 3)
                ? fontSize * 2.1
                : fontSize * 2.3;

    return SizedBox(
      width: width, // Define a largura do widget
      height: height, // Define a altura do widget
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Distribui os elementos uniformemente
        children: [
          // Exibe "R$"
          Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Alinha o texto na parte superior
            children: [
              Text(
                'R\$',
                style: TextStyle(
                  fontSize:
                      fontSize * 1.2, // Tamanho da fonte ajustado para "R$"
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold, // Negrito para destaque
                ),
              ),
            ],
          ),
          // Exibe a parte inteira (real) do valor
          Column(
            mainAxisAlignment:
                MainAxisAlignment.end, // Alinha o texto na parte inferior
            children: [
              Text(
                '$real,',
                style: TextStyle(
                  fontSize:
                      fontSizeReal, // Ajusta o tamanho da fonte com base no número de caracteres
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold, // Negrito para destaque
                ),
              ),
            ],
          ),
          // Exibe os centavos
          Text(
            cents,
            style: TextStyle(
              fontSize:
                  fontSize * 1.2, // Tamanho da fonte ajustado para os centavos
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold, // Negrito para destaque
            ),
          ),
          // Exibe a unidade de medida
          Column(
            mainAxisAlignment:
                MainAxisAlignment.end, // Alinha o texto na parte inferior
            children: [
              Text(
                '/ $measurUnity',
                style: TextStyle(
                  fontSize: fontSize, // Tamanho padrão da fonte
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold, // Negrito para destaque
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
