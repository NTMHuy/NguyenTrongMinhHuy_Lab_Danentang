import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/weather_model.dart';
import '../models/weather_style.dart';
import '../services/weather.dart';
import '../widgets/weather_background.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weather});

  final WeatherModel weather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherService _service = WeatherService();
  late WeatherModel weather;

  @override
  void initState() {
    super.initState();
    weather = widget.weather;
  }

  Future<void> _update(Future<WeatherModel> Function() loader) async {
    try {
      final newWeather = await loader();
      if (!mounted) return;
      setState(() => weather = newWeather);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _searchCity() async {
    final typedName = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const CityScreen()),
    );
    if (!mounted) return;
    if (typedName != null && typedName.trim().isNotEmpty) {
      _update(() => _service.getCityWeather(typedName));
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = weather.style;

    return Scaffold(
      body: WeatherBackground(
        colors: style.colors,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(child: _buildHero(style)),
                  ),
                ),
                _buildDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.place_outlined, size: 26),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            weather.cityName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
        _RoundAction(
          icon: Icons.my_location,
          tooltip: 'Dùng vị trí hiện tại',
          onPressed: () => _update(_service.getLocationWeather),
        ),
        const SizedBox(width: 8),
        _RoundAction(
          icon: Icons.search,
          tooltip: 'Tìm thành phố',
          onPressed: _searchCity,
        ),
      ],
    );
  }

  Widget _buildHero(WeatherStyle style) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: SvgPicture.asset(
            style.iconAsset,
            key: ValueKey(style.iconAsset),
            width: 190,
            height: 190,
            semanticsLabel: weather.descriptionText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${weather.temperature.round()}°',
          style: const TextStyle(
            fontSize: 104,
            fontWeight: FontWeight.w200,
            height: 1.0,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 4),
        Text(weather.descriptionText, style: const TextStyle(fontSize: 22)),
      ],
    );
  }

  Widget _buildDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            weather.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const Divider(color: Colors.white24, height: 28),
          Row(
            children: [
              _stat('${weather.feelsLike.round()}°', 'Cảm giác như'),
              _stat('${weather.humidity}%', 'Độ ẩm'),
              _stat('${weather.windSpeed.toStringAsFixed(1)} m/s', 'Gió'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// Nút tròn nền kính mờ dùng ở thanh trên
class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.14),
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}