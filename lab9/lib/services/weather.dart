import '../constants.dart';
import '../models/weather_model.dart';
import 'location.dart';
import 'networking.dart';

class WeatherService {
  static const _host = 'api.openweathermap.org';
  static const _path = '/data/2.5/weather';

  // Thời tiết theo vị trí GPS
  Future<WeatherModel> getLocationWeather() async {
    final location = Location();
    await location.getCurrentLocation();

    final url = Uri.https(_host, _path, {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': kApiKey,
      'units': 'metric',
      'lang': 'vi',
    });
    return WeatherModel.fromJson(await NetworkHelper().getData(url));
  }

  // Thời tiết theo tên thành phố
  Future<WeatherModel> getCityWeather(String cityName) async {
    final url = Uri.https(_host, _path, {
      'q': cityName.trim(),
      'appid': kApiKey,
      'units': 'metric',
      'lang': 'vi',
    });
    return WeatherModel.fromJson(await NetworkHelper().getData(url));
  }
}