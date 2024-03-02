import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grittask/screens/controller/wheather_controller.dart';
import 'package:grittask/screens/home_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? position;
  LocationPermission? locationPermission;

  Future<Position> determinePosition() async {
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission denied");
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void setPosition() async {
    position = await determinePosition();
    setState(() {});

    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  void initState() {
    setPosition();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherBook>(     //consumer called to get provider
      builder: (context, value, child) {
        return DefaultTabController(
          length: value.items.length + 1,
          initialIndex: 0,
          child: Scaffold(
            body: TabBarView(
              children: [
                    locationPermission == LocationPermission.denied ||
                            locationPermission ==
                                LocationPermission.deniedForever ||
                            position == null
                        ? const Center(
                            child: Text(
                                "Enable Location Permission from settings"),
                          )
                        : WeatherView(
                            lat: position!.latitude,
                            lon: position!.longitude,
                            isRemovable: false,
                          )
                  ] +
                  (value.items
                      .map((weatherSearchItem) => WeatherView(
                            lat: weatherSearchItem.lat,
                            lon: weatherSearchItem.lon,
                            isRemovable: true,
                          ))
                      .toList()),
            ),
            floatingActionButton: SizedBox(
              height: 40,
              width: 90,
              child: FittedBox(
                alignment: Alignment.centerRight,
                child: FloatingActionButton.extended(
                  extendedPadding: const EdgeInsets.symmetric(horizontal: 17),
                  isExtended: true,
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    "Add City",
                  ),
                  onPressed: () async {
                    
                    await Navigator.of(context).pushNamed('/search-weather');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(
                  bottom: 20, top: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: TabBar(
                splashBorderRadius: BorderRadius.circular(60),
                splashFactory: NoSplash.splashFactory,
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: -16, vertical: 5),
                isScrollable: true,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(60),
                ),
                unselectedLabelColor: Colors.black87,
                tabs: [
                      Tab(
                        child: Row(
                          children: const [
                            Icon(Icons.cloud_circle_rounded),
                            SizedBox(width: 5),
                            Text(
                              "Geolocation",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ] +
                    value.items
                        .map(
                          (weatherSearchItem) => Tab(
                            child: Row(
                              children: [
                                const Icon(Icons.cloud_circle_rounded),
                                const SizedBox(width: 5),
                                Text(
                                  weatherSearchItem.name!.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
