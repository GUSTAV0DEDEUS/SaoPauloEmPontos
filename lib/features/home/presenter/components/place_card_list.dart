import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/providers/tourist_attraction_provider.dart';
import 'package:sp_pontos/features/home/presenter/components/place_card.dart';

class PlaceCardList extends StatelessWidget {
  const PlaceCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TouristAttractionProvider>(context);
    final places = provider.places;

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
        mainAxisExtent: 190,
      ),
      itemCount: places.length,
      padding: EdgeInsets.only(bottom: 20),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return PlaceCard(
          title: places[index].name,
          imageUrl: places[index].imageUrl,
          rating: '4.9 (112)',
          location: places[index].location,
        );
      },
    );
  }
}
