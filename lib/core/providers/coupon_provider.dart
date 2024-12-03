import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sp_pontos/core/models/coupon_model.dart';
import 'package:sp_pontos/core/services/coupon_service.dart';
import 'package:sp_pontos/features/auth/data/auth_repository.dart';

class CouponProvider extends ChangeNotifier {
  final CouponService _couponService = CouponService();
  List<CouponModel> _coupons = [];
  bool _isLoading = false;

  List<CouponModel> get coupons => _coupons;
  bool get isLoading => _isLoading;

  Future<void> fetchCoupons() async {
    _isLoading = true;
    notifyListeners();

    try {
      _coupons = await _couponService.getAllCoupons();
    } catch (e) {
      // Handle error
      print('Error fetching coupons: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> activateCoupon(String couponId) async {
    final userId = AuthRepository.idUser;
    if (userId == null) {
      print('Error: User not logged in');
      return;
    }

    if (couponId.isEmpty) {
      print('Error: Coupon ID is empty');
      return;
    }

    try {
      await _couponService.activateCoupon(couponId, userId);
      _coupons = _coupons.map((coupon) {
        if (coupon.id == couponId) {
          return coupon.copyWith(usedBy: [...coupon.usedBy, userId]);
        }
        return coupon;
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error activating coupon: $e');
    }
  }

  bool isCouponUsedByCurrentUser(String couponId) {
    final userId = AuthRepository.idUser;
    if (userId == null) return false;

    final coupon = _coupons.firstWhere(
      (c) => c.id == couponId,
      orElse: () => CouponModel(
        id: '',
        title: '',
        discount: '',
        location: '',
        validDate: Timestamp.now(),
        usedBy: [],
        imageUrl: '',
      ),
    );
    return coupon.usedBy.contains(userId);
  }
}
