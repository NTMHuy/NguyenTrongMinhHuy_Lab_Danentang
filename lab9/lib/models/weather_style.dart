import 'package:flutter/material.dart';

class WeatherStyle {
  const WeatherStyle({required this.iconAsset, required this.colors});

  final String iconAsset;
  final List<Color> colors; // luôn 2 màu để nền chuyển mượt

  static const fallback = WeatherStyle(
    iconAsset: 'assets/icons/clouds.svg',
    colors: [Color(0xFF1B2440), Color(0xFF3B4A75)],
  );

  // Ánh xạ mã điều kiện của OpenWeatherMap -> icon + màu nền
  factory WeatherStyle.fromCondition(int id) {
    if (id < 300) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/thunderstorm.svg',
        colors: [Color(0xFF171B33), Color(0xFF3A2F5B)],
      );
    }
    if (id < 400) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/drizzle.svg',
        colors: [Color(0xFF1F2A44), Color(0xFF3B4F73)],
      );
    }
    if (id < 600) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/rain.svg',
        colors: [Color(0xFF17203A), Color(0xFF2E4670)],
      );
    }
    if (id < 700) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/snow.svg',
        colors: [Color(0xFF24405F), Color(0xFF4A709A)],
      );
    }
    if (id < 800) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/atmosphere.svg',
        colors: [Color(0xFF3B4352), Color(0xFF6F7A8D)],
      );
    }
    if (id == 800) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/clear.svg',
        colors: [Color(0xFF1A4478), Color(0xFF2F78BD)],
      );
    }
    if (id <= 804) {
      return const WeatherStyle(
        iconAsset: 'assets/icons/clouds.svg',
        colors: [Color(0xFF34435F), Color(0xFF5A6E93)],
      );
    }
    return fallback;
  }
}