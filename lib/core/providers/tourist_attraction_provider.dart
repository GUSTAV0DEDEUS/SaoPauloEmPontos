import 'package:flutter/material.dart';
import 'package:sp_pontos/core/models/place_carrousel.dart';
import 'package:sp_pontos/core/services/tourist_attraction_service.dart';

class TouristAttractionProvider with ChangeNotifier {
  List<PlaceCarrousel> _places = [];
  bool _isLoading = false;

  List<PlaceCarrousel> get places => _places;

  bool get isLoading => _isLoading;

  final TouristAttractionService _service = TouristAttractionService();

  Future<void> fetchTouristAttractions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _places = await _service.fetchTouristAttractions();
    } catch (e) {
      print('Error fetching tourist attractions: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
  Future<void> fetchTouristAttractionsLimit() async {
    _isLoading = true;
    notifyListeners();

    try {
      _places = await _service.fetchTouristAttractionsLimit();
    } catch (e) {
      print('Error fetching tourist attractions: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllTouristAttractions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _places = await _service.fetchAllTouristAttractions();
    } catch (e) {
      print('Error fetching tourist attractions: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
