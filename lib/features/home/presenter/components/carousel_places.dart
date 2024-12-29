import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/components/image.dart';
import 'package:sp_pontos/core/models/place_carrousel.dart';
import 'package:sp_pontos/core/providers/tourist_attraction_provider.dart';

class CarouselPlaces extends StatefulWidget {
  const CarouselPlaces({super.key});

  @override
  _CarouselPlacesState createState() => _CarouselPlacesState();
}

class _CarouselPlacesState extends State<CarouselPlaces> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Use WidgetsBinding para garantir que a função seja chamada após a fase de build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TouristAttractionProvider>(context, listen: false)
          .fetchTouristAttractionsLimit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TouristAttractionProvider>(context);
    final List<PlaceCarrousel> places = provider.places;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (places.isEmpty) {
      // Se não houver lugares, pode retornar uma mensagem ou um widget vazio.
      return const Center(child: Text("Nenhum local disponível"));
    }

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: places.map((place) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageComponent(
                imageUrl: place.imageUrl,
                height: double.infinity,
              ),
            );
          }).toList(),
        ),
        // Exibe o DotsIndicator somente se houver lugares.
        if (places.length > 1)
          Positioned(
            top: 11,
            left: 16,
            child: DotsIndicator(
              dotsCount: places.length,
              position: _currentIndex,
              decorator: DotsDecorator(
                activeColor: Colors.blue,
                color: Colors.grey,
                spacing: const EdgeInsets.only(right: 12),
              ),
            ),
          ),
        Positioned(
          bottom: 11,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                places[_currentIndex].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: Colors.white, size: 16),
                  Text(
                    places[_currentIndex].location,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
