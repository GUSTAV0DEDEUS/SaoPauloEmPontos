import 'package:flutter/material.dart';
import 'package:sp_pontos/features/home/presenter/components/place_card.dart';

class PlaceCardList extends StatelessWidget {
  final List<Map<String, String>> places;

  const PlaceCardList({super.key, required this.places});

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
      itemCount: places.length,
      padding: EdgeInsets.only(bottom: 20),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return PlaceCard(
          title: places[index]['title']!,
          imageUrl: places[index]['imageUrl']!,
          rating: places[index]['rating']!,
          location: places[index]['location']!,
        );
      },
    );
  }
}
