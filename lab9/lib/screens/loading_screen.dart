import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';
import '../models/weather_model.dart';
import '../services/weather.dart';
import 'location_screen.dart';
import '../models/weather_style.dart';
import '../widgets/weather_background.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final WeatherService _service = WeatherService();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      WeatherModel weather;
      try {
        weather = await _service.getLocationWeather();
      } catch (_) {
        // Không lấy được GPS: dùng thành phố mặc định
        weather = await _service.getCityWeather(kDefaultCity);
      }
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LocationScreen(weather: weather)),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => errorMessage = e.toString());
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherBackground(
        colors: WeatherStyle.fallback.colors,
        child: Center(
          child: errorMessage == null
              ? const SpinKitDoubleBounce(color: Colors.white, size: 100.0)
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          setState(() => errorMessage = null);
                          loadWeather();
                        },
                        child: const Text('Thử lại'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}