import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grittask/model/wheather_model.dart';
import 'package:grittask/services/wheather_services.dart';
import 'package:grittask/widgets/alarm_screen.dart';

class WeatherView extends StatefulWidget {
  final double lat;
  final double lon;
  final bool isRemovable;
  const WeatherView(
      {super.key,
      required this.lat,
      required this.lon,
      required this.isRemovable});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  Position? position;
  LocationPermission? locationPermission;

  final weatherService = WeatherService();

  Future<void> refresh() async {
    setState(() {});
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  Future<Weather> weatherInfo(double lat, double lon) async {
    return await weatherService.getWeatherGeo(latitude: lat, longitude: lon);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherInfo(widget.lat, widget.lon),
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? RefreshIndicator(
                onRefresh: refresh,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AlarmScreen()),
                            );
                          },
                          child: const Text('Set Alarm'),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          snapshot.data!.name,
                          style: const TextStyle(
                              fontSize: 35, color: Colors.white),
                        ),
                        const Icon(
                          Icons.location_on_sharp,
                          size: 15,
                        ),
                        const SizedBox(height: 100),
                        Text(
                          '${snapshot.data!.tempC.floor().toString()}°',
                          style: const TextStyle(
                              fontSize: 80, color: Colors.white),
                        ),
                        Text(
                          "${snapshot.data!.region}, ${snapshot.data!.country}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                "https:${snapshot.data!.conditionIcon}",
                                color: Colors.white),
                            Text(
                              snapshot.data!.conditionText,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
