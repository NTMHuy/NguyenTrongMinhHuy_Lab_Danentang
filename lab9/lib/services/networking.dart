import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherException implements Exception {
  WeatherException(this.message);
  final String message;

  @override
  String toString() => message;
}

class NetworkHelper {
  Future<Map<String, dynamic>> getData(Uri url) async {
    final http.Response response;
    try {
      response = await http.get(url);
    } catch (_) {
      throw WeatherException('Không kết nối được mạng.');
    }

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 401:
        throw WeatherException(
            'API key không hợp lệ hoặc chưa được kích hoạt.');
      case 404:
        throw WeatherException('Không tìm thấy thành phố.');
      default:
        throw WeatherException('Lỗi máy chủ (${response.statusCode}).');
    }
  }
}