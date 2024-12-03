import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/components/text_app.dart';
import 'package:sp_pontos/core/providers/coupon_provider.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';

class CuponCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String validDate;
  final String location;
  final String discount;
  final List<String> usedBy;
  final String couponId;

  const CuponCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.validDate,
    required this.location,
    required this.discount,
    required this.usedBy,
    required this.couponId,
  });

  @override
  Widget build(BuildContext context) {
    final couponProvider = Provider.of<CouponProvider>(context);
    final isUsed = couponProvider.isCouponUsedByCurrentUser(couponId);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(),
                _buildContent(context, isUsed),
              ],
            ),
            if (isUsed) _buildUsedOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: _buildDiscountBadge(),
        ),
      ],
    );
  }

  Widget _buildDiscountBadge() {
    return DottedBorder(
      dashPattern: [6, 4],
      strokeWidth: 1,
      color: AppColors.white,
      borderType: BorderType.RRect,
      radius: Radius.circular(99),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.percent, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              discount,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isUsed) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextApp(
                  label: title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              _buildValidDate(),
            ],
          ),
          SizedBox(height: 8),
          _buildLocation(),
          SizedBox(height: 16),
          _buildActivateButton(context, isUsed),
        ],
      ),
    );
  }

  Widget _buildValidDate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.gray),
        SizedBox(width: 4),
        TextApp(label: validDate, color: AppColors.gray),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 16, color: AppColors.gray),
        SizedBox(width: 4),
        Expanded(child: TextApp(label: location, color: AppColors.gray)),
      ],
    );
  }

  Widget _buildActivateButton(BuildContext context, bool isUsed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isUsed ? null : () => _activateCoupon(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: isUsed ? Colors.grey : AppColors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(isUsed ? 'Cupom Resgatado' : 'Resgatar Cupom'),
      ),
    );
  }

  void _activateCoupon(BuildContext context) async {
    final couponProvider = Provider.of<CouponProvider>(context, listen: false);
    await couponProvider.activateCoupon(couponId);
  }

  Widget _buildUsedOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'RESGATADO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
