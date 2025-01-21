import 'package:flutter/material.dart';
import 'package:market_finder/components/price.dart';
import 'package:market_finder/components/show_img.dart';
import 'package:market_finder/models/theme/theme.dart';

// Um widget de cartão de produto usado para exibir informações sobre um produto em um formato visual
class SearchCardProduct extends StatelessWidget {
  // Parâmetros obrigatórios para configurar o widget
  final String img; // Imagem codificada do produto
  final String nameProduct; // Nome do produto
  final String valueProduct; // Valor do produto
  final String nameStore; // Nome da loja
  final String un; // Unidade de medida do produto
  final bool haveDelivery; // Indica se há entrega disponível
  final Function() onTap; // Função chamada ao clicar no cartão
  final Function()
      onAddCartTap; // Função chamada ao clicar no botão de adicionar ao carrinho
  final double width; // Largura do cartão
  final double height; // Altura do cartão

  // Construtor para inicializar os valores obrigatórios
  const SearchCardProduct({
    super.key,
    required this.img,
    required this.nameProduct,
    required this.valueProduct,
    required this.nameStore,
    required this.un,
    required this.width,
    required this.height,
    required this.haveDelivery,
    required this.onTap,
    required this.onAddCartTap,
  });

  @override
  Widget build(BuildContext context) {
    double widthElements =
        width * 0.9; // Calcula a largura interna dos elementos

    return InkWell(
      onTap: onTap, // Define o comportamento ao clicar no cartão
      child: Container(
        width: width, // Define a largura do cartão
        height: height, // Define a altura do cartão
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              height * 0.06), // Define as bordas arredondadas
          color: AppTheme.colors.white, // Define a cor de fundo
          boxShadow: [
            // Configura uma sombra para dar destaque ao cartão
            BoxShadow(
              color: AppTheme.colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // Distribui os elementos uniformemente
          children: [
            // Widget para mostrar a imagem
            Padding(
              padding: EdgeInsets.only(top: height * 0.03),
              child: buildImage(img, widthElements, height * 0.35),
            ),
            SizedBox(
              width: widthElements, // Define a largura do elemento de texto
              child: Text(
                nameProduct, // Nome do produto
                style: TextStyle(
                  fontSize: height * 0.1, // Fonte proporcional à altura
                  fontFamily: AppTheme.fonts.primaryFont,
                ),
                maxLines: 1, // Limita o texto a uma linha
                overflow: TextOverflow
                    .ellipsis, // Adiciona '...' se o texto for muito longo
              ),
            ),
            // Componente para exibir o preço
            Price(
              productValue: valueProduct, // Valor do produto
              measurUnity: un, // Unidade de medida
              width: widthElements, // Corrigido como 'width'
              height: height * 0.27, // Altura do componente de preço
              fontSize: height * 0.08, // Tamanho da fonte proporcional
              fontFamily: AppTheme.fonts.secudaryFont,
            ),
            SizedBox(
              width: width * 0.9, // Define a largura do container
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Distribui os elementos na horizontal
                children: [
                  // Row para exibir ícone de entrega (se disponível) e a distância
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (haveDelivery)
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.05),
                          child: Icon(AppTheme.icons.delivery),
                        ),
                      Text(
                        // Texto para exibir o nome da loja
                        nameStore,
                        style: TextStyle(
                          fontSize:
                              height * 0.06, // Tamanho da fonte proporcional
                          fontFamily: AppTheme.fonts.primaryFont,
                        ),
                      ),
                    ],
                  ),
                  // Botão para adicionar ao carrinho
                  SizedBox(
                    width: height * 0.2, // Largura do botão
                    height: height * 0.2, // Altura do botão
                    child: IconButton(
                      onPressed:
                          onAddCartTap, // Define a ação ao clicar no botão
                      icon: Icon(AppTheme
                          .icons.addCart), // Ícone de adicionar ao carrinho
                      color: AppTheme.colors.primary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
