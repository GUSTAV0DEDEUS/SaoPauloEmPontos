import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/components/image.dart';
import 'package:sp_pontos/features/explore/presenter/components/actions.dart';
import 'package:sp_pontos/features/explore/presenter/components/infos_photo.dart';
import 'package:sp_pontos/features/explore/presenter/components/profile_component.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageComponent(
            imageUrl:
                'https://www.saopauloinfoco.com.br/wp-content/uploads/2013/03/Parque-do-Ibirapuera_Cidade-de-S%C3%A3o-Paulo.jpg',
            height: double.infinity,
          ),
          Positioned(
            top: 40,
            left: 9,
            child: ProfileComponent(
              imageUrl: "assets/images/avatar.jpeg",
              name: "Gustavo",
            ),
          ),
          Positioned(bottom: 20, left: 9, child: InfosPhoto()),
          Positioned(right: 20, bottom: 50, child: ActionsComponent()),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
