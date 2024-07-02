import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/weather_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App☁️'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city or state name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = _cityController.text;
                if (city.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeather(city);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeatherDetailsScreen()),
                  );
                }
              },
              child: Text('Get Weather'),
            ),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return CircularProgressIndicator();
                } else if (weatherProvider.error != null) {
                  return Text(
                    "No such state or city exist",
                    style: TextStyle(color: Colors.black),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
