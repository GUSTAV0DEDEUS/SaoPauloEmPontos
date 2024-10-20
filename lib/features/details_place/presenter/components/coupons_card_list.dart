import 'package:flutter/material.dart';
import 'package:sp_pontos/features/details_place/presenter/components/coupon_card.dart';

class CouponsCardList extends StatelessWidget {
  final List<Map<String, String>> coupons;

  const CouponsCardList({super.key, required this.coupons});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
        mainAxisExtent: 190,
      ),
      itemCount: coupons.length,
      padding: EdgeInsets.only(bottom: 20),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CouponCard(
          title: coupons[index]['title']!,
          imageUrl: coupons[index]['imageUrl']!,
        );
      },
    );
  }
}
