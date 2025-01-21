import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class PagesCounter extends StatelessWidget {
  // Parâmetros obrigatórios
  final int actualPage; // Página atual exibida
  final int totalPages; // Total de páginas disponíveis
  final double height; // Altura do widget
  final double width; // Largura do widget
  final Function(int) onPageChanged; // Função para executar ao mudar de página

  const PagesCounter({
    super.key,
    required this.actualPage,
    required this.totalPages,
    required this.height,
    required this.width,
    required this.onPageChanged,
  });

  // Método para criar uma lista de páginas com limites definidos
  List<Widget> _buildPageSet(int start, int end, {bool addEllipsis = false}) {
    List<Widget> pageWidgets = [];
    for (int i = start; i <= end; i++) {
      pageWidgets.add(_buildPageButton(i)); // Adiciona os botões de página
    }
    // Adiciona reticências se necessário
    if (addEllipsis) {
      pageWidgets.add(_buildEllipsis());
      pageWidgets.add(_buildPageButton(totalPages));
    }
    return pageWidgets;
  }

  // Método para construir os números das páginas
  List<Widget> _buildPageNumbers() {
    List<Widget> pageWidgets = [];

    int maxStartPages = 4;
    int maxEndPages = 3;

    // Define quando mostrar reticências
    bool showStartEllipsis = actualPage > maxStartPages;
    bool showEndEllipsis = actualPage < totalPages - maxEndPages;

    // Lógica para páginas intermediárias com reticências em ambos os lados
    if (showStartEllipsis && showEndEllipsis) {
      pageWidgets.add(_buildPageButton(1));
      pageWidgets.add(_buildEllipsis());
      pageWidgets.addAll(_buildPageSet(actualPage - 2, actualPage + 2));
      pageWidgets.add(_buildEllipsis());
      pageWidgets.add(_buildPageButton(totalPages));
    }
    // Lógica para primeiras páginas com reticências no final
    else if (showEndEllipsis) {
      pageWidgets.addAll(_buildPageSet(1, maxStartPages + 1));
      pageWidgets.add(_buildEllipsis());
      pageWidgets.addAll(_buildPageSet(totalPages - 1, totalPages));
    }
    // Lógica para últimas páginas com reticências no início
    else if (showStartEllipsis) {
      pageWidgets.add(_buildPageButton(1));
      pageWidgets.add(_buildPageButton(2));
      pageWidgets.add(_buildEllipsis());
      pageWidgets
          .addAll(_buildPageSet(totalPages - (maxEndPages + 1), totalPages));
    }

    return pageWidgets;
  }

  // Função auxiliar para construir os botões de página
  Widget _buildPageButton(int pageNumber) {
    final double fontSize =
        width * 0.07; // Calcula o tamanho da fonte com base na largura
    return SizedBox(
      width: width * 0.1, // Limita a largura do botão
      child: GestureDetector(
        onTap: () => onPageChanged(pageNumber), // Muda a página ao clicar
        child: FittedBox(
          fit: BoxFit
              .scaleDown, // Garante que o texto seja dimensionado para caber na largura
          child: Text(
            pageNumber.toString(),
            style: TextStyle(
              fontFamily: AppTheme.fonts.secudaryFont,
              fontSize: (actualPage == pageNumber)
                  ? fontSize * 1.4
                  : fontSize, // Destaca a página atual
              color: (actualPage == pageNumber)
                  ? AppTheme.colors.primary
                  : AppTheme.colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Função auxiliar para criar o widget das reticências
  Widget _buildEllipsis() {
    final double fontSize =
        height * 0.4; // Calcula o tamanho da fonte com base na altura
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: height * 0.1), // Adiciona espaçamento horizontal
      child: Text(
        '...',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTheme.fonts.secudaryFont,
          fontSize: fontSize,
          color: AppTheme.colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Define a altura do widget
      width: width, // Define a largura do widget
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Espaça os elementos uniformemente
        children: _buildPageNumbers(), // Constrói os números das páginas
      ),
    );
  }
}
