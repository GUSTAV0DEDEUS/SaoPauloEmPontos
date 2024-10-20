import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/features/details_place/presenter/components/coupons_card_list.dart';
import 'package:sp_pontos/features/details_place/presenter/components/imagem_background.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});

  final List<Map<String, String>> coupons = [
    {
      'title': 'Prambanan Temple',
      'imageUrl':
          "https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg",
      'rating': '4.9 (112)',
      'location': 'Cidade de São Paulo - SP',
    },
    {
      'title': 'Borobudur Temple',
      'imageUrl':
          'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
      'rating': '4.9 (112)',
      'location': 'Cidade de São Paulo - SP',
    },
    {
      'title': 'Borobudur Temple',
      'imageUrl':
          'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
      'rating': '4.9 (112)',
      'location': 'Cidade de São Paulo - SP',
    },
    {
      'title': 'Borobudur Temple',
      'imageUrl':
          'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
      'rating': '4.9 (112)',
      'location': 'Cidade de São Paulo - SP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de abas
      child: Scaffold(
        backgroundColor: AppColors.lightGray,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: false,
                pinned: false,
                collapsedHeight: 380,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: ImagemBackground(), // Imagem de fundo
                ),
                bottom: TabBar(
                  indicatorColor: AppColors.blue,
                  tabs: [
                    Tab(text: 'Detalhes'),
                    Tab(text: 'Fotos'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visão Geral',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'O Parque Ibirapuera é um dos principais e mais icônicos espaços verdes de São Paulo, conhecido por sua vasta área de lazer, cultura e natureza. Inaugurado em 1954, ele oferece uma grande variedade de atividades, incluindo pistas de caminhada, ciclovias, áreas de piquenique, além de museus e eventos culturais.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Cupons',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CouponsCardList(coupons: coupons),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text('Galeria de Fotos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
