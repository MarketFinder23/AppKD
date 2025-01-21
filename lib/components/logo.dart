import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Um widget que exibe uma logo SVG com altura ajustável
class Logo extends StatelessWidget {
  // Parâmetro obrigatório para definir a altura da logo
  final double height;
  // Caminho ou nome do arquivo SVG a ser exibido
  final String svg;

  // Construtor que exige os parâmetros obrigatórios
  const Logo({
    super.key,
    required this.height,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg, // Especifica o caminho/nome do arquivo SVG
      height: height, // Define a altura do SVG
      fit: BoxFit
          .contain, // Ajusta o SVG para se conter dentro do espaço fornecido
      placeholderBuilder: (context) => const Center(
        // Placeholder mostrado enquanto o SVG está carregando
        child:
            CircularProgressIndicator(), // Indicador de progresso durante o carregamento
      ),
    );
  }
}
