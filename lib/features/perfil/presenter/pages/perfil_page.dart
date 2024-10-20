import 'package:flutter/material.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/features/perfil/presenter/components/photos_component.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 180,
                    ),
                    itemBuilder: (context, index) {
                      return PhotosComponent(
                        imageUrl:
                            "https://ibirapuera.org/wp/wp-content/uploads/2016/03/RN-Ibirapuera-Aerea-20150121-5-1-foto-destacada-resized.jpg",
                        liked: "44",
                        location: "Parque Ibirapuera",
                      );
                    },
                    itemCount: 4,
                  ),
                  Center(child: Text('Resgates')),
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
