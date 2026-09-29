import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const ClimaApp());
}

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima',
      theme: ThemeData(useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  String city = 'Da Nang';
  String country = 'Vietnam';
  double? temperature;
  int? weatherCode;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    searchCity('Da Nang');
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  // Tìm kiếm thành phố và lấy tọa độ
  Future<void> searchCity(String cityName) async {
    if (cityName.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final geoUrl = Uri.https(
        'geocoding-api.open-meteo.com',
        '/v1/search',
        {
          'name': cityName,
          'count': '1',
          'language': 'en',
          'format': 'json',
        },
      );

      final geoResponse = await http.get(geoUrl);

      if (geoResponse.statusCode != 200) {
        throw Exception('Không thể tìm kiếm địa điểm.');
      }

      final geoData = jsonDecode(geoResponse.body);
      final results = geoData['results'];

      if (results == null || results.isEmpty) {
        throw Exception('Không tìm thấy thành phố "$cityName".');
      }

      final place = results[0];
      final latitude = place['latitude'];
      final longitude = place['longitude'];

      await getWeather(
        latitude,
        longitude,
        place['name'],
        place['country'] ?? '',
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString().replaceFirst('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Lấy dữ liệu thời tiết theo tọa độ
  Future<void> getWeather(
    double latitude,
    double longitude,
    String cityName,
    String countryName,
  ) async {
    final weatherUrl = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,weather_code',
        'timezone': 'auto',
      },
    );

    final response = await http.get(weatherUrl);

    if (response.statusCode != 200) {
      throw Exception('Không thể lấy dữ liệu thời tiết.');
    }

    final data = jsonDecode(response.body);
    final current = data['current'];

    if (mounted) {
      setState(() {
        city = cityName;
        country = countryName;
        temperature = (current['temperature_2m'] as num).toDouble();
        weatherCode = current['weather_code'] as int;
      });
    }
  }

  // Lấy vị trí hiện tại
  Future<void> getCurrentLocation() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Vui lòng bật dịch vụ định vị.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Ứng dụng chưa được cấp quyền vị trí.');
      }

      final position = await Geolocator.getCurrentPosition();

      await getWeather(
        position.latitude,
        position.longitude,
        'Current Location',
        '',
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString().replaceFirst('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Chuyển mã thời tiết thành mô tả
  String getWeatherDescription(int? code) {
    if (code == null) return 'Unknown';

    if (code == 0) return 'Clear sky';
    if (code == 1) return 'Mainly clear';
    if (code == 2) return 'Partly cloudy';
    if (code == 3) return 'Overcast';
    if (code == 45 || code == 48) return 'Fog';
    if (code >= 51 && code <= 57) return 'Drizzle';
    if (code >= 61 && code <= 67) return 'Rain';
    if (code >= 71 && code <= 77) return 'Snow';
    if (code >= 80 && code <= 82) return 'Rain showers';
    if (code == 85 || code == 86) return 'Snow showers';
    if (code >= 95) return 'Thunderstorm';

    return 'Unknown';
  }

  IconData getWeatherIcon(int? code) {
    if (code == null) return Icons.cloud;

    if (code == 0) return Icons.wb_sunny;
    if (code == 1 || code == 2) return Icons.wb_cloudy;
    if (code == 3) return Icons.cloud;
    if (code == 45 || code == 48) return Icons.foggy;
    if (code >= 51 && code <= 67) return Icons.grain;
    if (code >= 71 && code <= 86) return Icons.ac_unit;
    if (code >= 95) return Icons.thunderstorm;

    return Icons.water_drop;
  }

  // Hộp thoại tìm kiếm thành phố
  void showSearchDialog() {
    _cityController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search city'),
          content: TextField(
            controller: _cityController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter city name',
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              Navigator.pop(context);
              searchCity(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = _cityController.text;
                Navigator.pop(context);
                searchCity(value);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF56CCF2),
              Color(0xFF2F80ED),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: getCurrentLocation,
                      icon: const Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 30,
                      ),
                      tooltip: 'Current location',
                    ),
                    IconButton(
                      onPressed: showSearchDialog,
                      icon: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 30,
                      ),
                      tooltip: 'Search city',
                    ),
                  ],
                ),
                const Spacer(),
                if (isLoading)
                  const CircularProgressIndicator(
                    color: Colors.white,
                  )
                else if (errorMessage != null)
                  Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => searchCity(city),
                        child: const Text('Try again'),
                      ),
                    ],
                  )
                else
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          getWeatherIcon(weatherCode),
                          color: Colors.orangeAccent,
                          size: 120,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          temperature == null
                              ? '--°C'
                              : '${temperature!.round()}°C',
                          style: const TextStyle(
                            fontSize: 72,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          getWeatherDescription(weatherCode),
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '$city${country.isNotEmpty ? ', $country' : ''}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                const Text(
                  'Weather App - Clima',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
