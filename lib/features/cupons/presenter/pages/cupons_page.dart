import 'package:flutter/material.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/components/text_app.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/features/cupons/presenter/components/cupon_card.dart';

class CuponsPage extends StatelessWidget {
  const CuponsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextApp(
          label: 'Cupons',
          fontSize: 20,
          color: AppColors.black,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          CuponCard(
            imageUrl:
                'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
            title: 'Cantinho do Chef',
            validDate: 'Válido até 25 Outubro',
            location: 'Ao visitar o Parque Ibirapuera',
            discount: '20% de desconto',
          ),
          const SizedBox(height: 16),
          CuponCard(
            imageUrl:
                'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
            title: 'Terraço Gourmet',
            validDate: 'Válido até 2 Novembro',
            location: 'Ao visitar o Theatro Municipal de São Paulo',
            discount: '30% de desconto',
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
