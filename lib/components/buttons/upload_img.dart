import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class ButtonUpload extends StatelessWidget {
  // Callback para ação do botão
  final VoidCallback onPressed;

  // Largura dinâmica do botão passada por parâmetro
  final double width;

  // Construtor
  const ButtonUpload({
    Key? key,
    required this.onPressed,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cor derivada do tema da aplicação
    final Color color = AppTheme.colors.black;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
      crossAxisAlignment:
          CrossAxisAlignment.center, // Centraliza horizontalmente
      children: [
        // Texto descritivo do botão
        Text(
          'Imagem',
          style: TextStyle(
            color: color,
            fontSize: width * 0.1, // Tamanho da fonte proporcional à largura
          ),
        ),
        // Botão com borda e ícone
        Container(
          width: width, // Define a largura do botão
          height: width, // Define a altura igual à largura (quadrado)
          decoration: BoxDecoration(
            border: Border.all(
              color: color, // Cor da borda
              width: 1, // Espessura da borda
            ),
            borderRadius: BorderRadius.circular(
              width * 0.05, // Raio da borda proporcional à largura
            ),
          ),
          child: IconButton(
            highlightColor:
                Colors.transparent, // Remove o destaque ao pressionar
            icon: Icon(
              AppTheme.icons.upload, // Ícone de upload
              color: color, // Cor do ícone
              size: width * 0.4, // Tamanho do ícone proporcional à largura
            ),
            onPressed: onPressed, // Executa a ação passada por parâmetro
          ),
        ),
      ],
    );
  }
}
