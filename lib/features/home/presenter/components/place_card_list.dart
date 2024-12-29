import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/providers/tourist_attraction_provider.dart';
import 'package:sp_pontos/features/home/presenter/components/place_card.dart';

class PlaceCardList extends StatefulWidget {
  const PlaceCardList({super.key});

  @override
  _PlaceCardListState createState() => _PlaceCardListState();
}

class _PlaceCardListState extends State<PlaceCardList> {
  @override
  void initState() {
    super.initState();

    // Fetch all tourist attractions when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TouristAttractionProvider>(context, listen: false)
          .fetchAllTouristAttractions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TouristAttractionProvider>(context);

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final places = provider.places; // Now using the updated provider

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
      padding: const EdgeInsets.only(bottom: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return PlaceCard(
          title: places[index].name,
          imageUrl: places[index].imageUrl,
          description: places[index].description,
          rating: '4.9 (112)', // Replace with actual rating if available
          location: places[index].location,
          id: places[index].id,
        );
      },
    );
  }
}
