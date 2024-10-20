import 'package:flutter/material.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/features/home/presenter/components/carousel_places.dart';
import 'package:sp_pontos/features/home/presenter/components/place_card_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar pontos em sampa...',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselPlaces(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Explore São Paulo!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PlaceCardList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
