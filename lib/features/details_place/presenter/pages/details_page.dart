import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/providers/coupon_provider.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/features/details_place/presenter/components/coupons_card_list.dart';
import 'package:sp_pontos/features/details_place/presenter/components/imagem_background.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DateTime? _lastFetchTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final couponProvider = Provider.of<CouponProvider>(context, listen: false);

    // Fetch coupons only if more than 5 minutes have passed
    if (_lastFetchTime == null || DateTime.now().difference(_lastFetchTime!).inMinutes > 5) {
      couponProvider.fetchCoupons();
      _lastFetchTime = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Extracting values from arguments
    final String title = args['title'] ?? 'Título não disponível';
    final String imageUrl = args['imageUrl'] ?? '';
    final String rating = args['rating'] ?? 'Sem avaliação';
    final String location = args['location'] ?? 'Localização desconhecida';
    final String description = args['description'] ?? 'Descrição não disponível';
    final String? idTouristic = args['idTouristic']; // Nullable

    return Consumer<CouponProvider>(
      builder: (context, couponProvider, child) {
        // Filtrando cupons com base no idTouristic
        final List<Map<String, String>> coupons = couponProvider.coupons
            .where((coupon) => coupon.location == title)
            .map((coupon) => {
                  'title': coupon.title ?? 'Título não disponível',
                  'imageUrl': coupon.imageUrl ?? '',
                  'rating': coupon.discount ?? 'Sem desconto',
                  'location': coupon.location ?? 'Localização desconhecida',
                }).toList();

        return DefaultTabController(
          length: 2,
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
                      background: ImagemBackground(
                        title: title,
                        imageUrl: imageUrl,
                        location: location,
                      ),
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
                            description,
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
                          coupons.isNotEmpty
                              ? CouponsCardList(coupons: coupons)
                              : Text('Nenhum cupom disponível para este ponto turístico.'),
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
      },
    );
  }
}
