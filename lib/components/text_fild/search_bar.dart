import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class SearchBarEdited extends StatelessWidget {
  final double width;
  final double height;
  final String hint;
  final TextEditingController controller;
  final Function(String) onSubmited;

  const SearchBarEdited({
    super.key,
    required this.width,
    required this.hint,
    required this.onSubmited,
    required this.height,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Define o tamanho do ícone com base na altura fornecida
    double iconSize = height * 0.55;
    // Define o tamanho do botão com base na altura fornecida
    double btnSize = height * 0.8;
    // Define o tamanho da fonte proporcional à altura fornecida
    double fontSize = height * 0.26;

    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.2),
      child: Container(
        // Define a largura e altura do container da barra de busca
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppTheme.colors.white,
          // Define bordas arredondadas com raio igual à altura
          borderRadius: BorderRadius.circular(height),
          boxShadow: [
            BoxShadow(
              color: AppTheme.colors.black.withOpacity(0.3),
              offset: const Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 0.1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              // Define padding horizontal para o campo de texto
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Expanded(
                // O `Expanded` garante que o campo de texto ocupe o espaço disponível restante
                child: SizedBox(
                  // Define a largura do campo de texto
                  width: width * 0.7,
                  child: TextFormField(
                    style: TextStyle(fontSize: fontSize),
                    controller: controller,
                    cursorColor: AppTheme.colors.black,
                    // Callback executado ao submeter o texto
                    onFieldSubmitted: onSubmited,
                    decoration: InputDecoration(
                      hintText: hint,
                      // Remove a borda padrão do campo de texto
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            // Botão de ícone para buscar
            SizedBox(
              // Define a largura e altura do botão de ícone
              width: btnSize,
              height: btnSize,
              child: IconButton(
                onPressed: () {
                  // Executa a função `onSubmited` ao clicar no botão, usando o texto atual do controlador
                  onSubmited(controller.text);
                },
                iconSize: iconSize, // Define o tamanho do ícone
                highlightColor: AppTheme
                    .colors.white, // Cor de destaque ao pressionar o botão
                icon: Icon(
                  AppTheme.icons.search, // Ícone do botão
                  color: AppTheme.colors.black, // Cor do ícone
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
