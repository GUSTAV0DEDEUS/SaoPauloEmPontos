import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sp_pontos/core/models/coupon_model.dart';

class CouponService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CouponModel>> getAllCoupons() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('cupons').get();

      return querySnapshot.docs
          .map(
            (doc) => CouponModel.fromMap(doc.data() as Map<String, dynamic>)
                .copyWith(
              id: doc.id,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Error fetching coupons: $e');
    }
  }

  Future<void> activateCoupon(String couponId, String userId) async {
    if (couponId.isEmpty) {
      throw Exception('Coupon ID is empty');
    }

    try {
      DocumentReference couponDoc =
          _firestore.collection('cupons').doc(couponId);
      await couponDoc.update({
        'usedBy': FieldValue.arrayUnion([userId])
      });
    } catch (e) {
      throw Exception('Error activating coupon: $e');
    }
  }
}
