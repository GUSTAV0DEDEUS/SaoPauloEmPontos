import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/features/perfil/presenter/components/photos_component.dart';
import 'package:sp_pontos/core/services/photo_service.dart';
import 'package:sp_pontos/core/providers/coupon_provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final PhotoService _photoService = PhotoService();
  List<Map<String, dynamic>> _userPhotos = [];
  bool _isLoadingPhotos = true;

  @override
  void initState() {
    super.initState();
    _fetchUserPhotos();
  }

  Future<void> _fetchUserPhotos() async {
    final photos = await _photoService.fetchUserPhotos();
    setState(() {
      _userPhotos = photos;
      _isLoadingPhotos = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final couponProvider = Provider.of<CouponProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.jpeg'),
            ),
            SizedBox(height: 10),
            Text(
              'Fernanda Martins',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Amigos da Jornada',
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            TabBar(
              indicatorColor: AppColors.blue,
              labelColor: AppColors.black,
              dividerHeight: 0,
              unselectedLabelColor: AppColors.gray,
              tabs: [
                Tab(text: 'Fotos'),
                Tab(text: 'Resgates'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _isLoadingPhotos
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 180,
                          ),
                          itemBuilder: (context, index) {
                            final photo = _userPhotos[index];
                            return PhotosComponent(
                              imageUrl: photo['photoUrl'] ??
                                  'assets/images/default_image.png', // Default image
                              liked: (photo['likes'] != null
                                      ? photo['likes'].length
                                      : 0)
                                  .toString(), // Safely access length
                              location: photo['location'] ??
                                  'Localização desconhecida',
                            );
                          },
                          itemCount: _userPhotos.length,
                        ),
                  couponProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 180,
                          ),
                          itemBuilder: (context, index) {
                            final coupon = couponProvider.coupons[index];
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    coupon
                                        .imageUrl, // Assuming CouponModel has an imageUrl field
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    coupon.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Resgate: ${couponProvider.isCouponUsedByCurrentUser(coupon.id) ? "Usado" : "Disponível"}',
                                    style: TextStyle(
                                      color: couponProvider
                                              .isCouponUsedByCurrentUser(
                                                  coupon.id)
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: couponProvider.coupons.length,
                        ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomAppBar(),
      ),
    );
  }
}
