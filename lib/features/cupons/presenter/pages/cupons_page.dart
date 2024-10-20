import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/providers/coupon_provider.dart';
import 'package:sp_pontos/features/cupons/presenter/components/cupon_card.dart';

class CuponsPage extends StatefulWidget {
  const CuponsPage({Key? key}) : super(key: key);

  @override
  _CuponsPageState createState() => _CuponsPageState();
}

class _CuponsPageState extends State<CuponsPage> {
  late CouponProvider _couponProvider;

  @override
  void initState() {
    super.initState();
    _couponProvider = Provider.of<CouponProvider>(context, listen: false);
    _loadCoupons();
  }

  Future<void> _loadCoupons() async {
    await _couponProvider.fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Cupons'),
        centerTitle: true,
      ),
      body: Consumer<CouponProvider>(
        builder: (context, couponProvider, child) {
          if (couponProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (couponProvider.coupons.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_offer_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum cupom disponível',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadCoupons,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: couponProvider.coupons.length,
              itemBuilder: (context, index) {
                final coupon = couponProvider.coupons[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CuponCard(
                    imageUrl: coupon.imageUrl,
                    title: coupon.title,
                    validDate: coupon.validDate.toDate().toIso8601String(),
                    location: coupon.location,
                    discount: coupon.discount,
                    usedBy: coupon.usedBy,
                    couponId: coupon.id,
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
