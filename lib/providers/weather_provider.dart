import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  String? _lastSearchedCity;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get lastSearchedCity => _lastSearchedCity;

  final WeatherService _weatherService = WeatherService();

  WeatherProvider() {
    _loadLastSearchedCity();
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
      _saveLastSearchedCity(city);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
    _lastSearchedCity = city;
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    _lastSearchedCity = prefs.getString('lastSearchedCity');
    if (_lastSearchedCity != null) {
      await fetchWeather(_lastSearchedCity!);
    }
  }
}
