import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (weather != null) {
                weatherProvider.fetchWeather(weather.cityName);
              }
            },
          ),
        ],
      ),
      body: weatherProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : weather == null
              ? Center(child: Text('No weather data'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.cityName,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${weather.temperature.toStringAsFixed(1)} °C',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        weather.weatherDescription,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        'http://openweathermap.org/img/w/${weather.weatherIcon}.png',
                        scale: 0.5,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Humidity: ${weather.humidity}%',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Wind Speed: ${weather.windSpeed} m/s',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
    );
  }
}
