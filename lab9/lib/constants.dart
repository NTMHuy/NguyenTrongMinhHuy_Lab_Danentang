import 'package:flutter_dotenv/flutter_dotenv.dart';

// Đọc API key từ file .env (không ghi trực tiếp vào code)
String get kApiKey => dotenv.env['API_KEY'] ?? '';

// Thành phố dùng khi không lấy được vị trí GPS
const String kDefaultCity = 'Hanoi';