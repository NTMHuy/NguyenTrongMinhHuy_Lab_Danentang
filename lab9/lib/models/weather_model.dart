import 'weather_style.dart';

class WeatherModel {
  const WeatherModel({
    required this.condition,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.cityName,
  });

  final int condition;
  final double temperature; // °C
  final double feelsLike; // °C
  final int humidity; // %
  final double windSpeed; // m/s
  final String description;
  final String cityName;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      condition: json['weather'][0]['id'] as int,
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']?['speed'] as num?)?.toDouble() ?? 0,
      description: json['weather'][0]['description'] as String,
      cityName: json['name'] as String,
    );
  }

  WeatherStyle get style => WeatherStyle.fromCondition(condition);

  // Viết hoa chữ cái đầu của mô tả
  String get descriptionText => description.isEmpty
      ? description
      : description[0].toUpperCase() + description.substring(1);

  String get message {
    if (temperature > 30) return 'Trời nóng, nhớ uống đủ nước!';
    if (temperature > 22) return 'Thời tiết dễ chịu, mặc áo thoáng mát.';
    if (temperature > 15) return 'Hơi se lạnh, nên mang thêm áo khoác.';
    return 'Trời lạnh, hãy mặc thật ấm!';
  }
}