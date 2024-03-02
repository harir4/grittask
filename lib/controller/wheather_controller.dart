import 'dart:collection';
import 'package:flutter/material.dart';

class WeatherBook extends ChangeNotifier {
  final List<WeatherItem> _weatherItems = [];

  UnmodifiableListView<WeatherItem> get items =>
      UnmodifiableListView(_weatherItems);

  void add({required WeatherItem weatherItem}) {
    if (!_weatherItems.contains(weatherItem)) {
      _weatherItems.add(weatherItem);
      notifyListeners();
    }
  }

  void remove({required double lat, required double lon}) {
    _weatherItems
        .removeWhere((element) => element.lat == lat && element.lon == lon);
    notifyListeners();
  }

  void reset() {
    _weatherItems.clear();
    notifyListeners();
  }

  int get length => _weatherItems.length;
}

class WeatherItem {
  final int? id;
  final String? name;
  final String? region;
  final String? country;
  final double lat;
  final double lon;
  final String? url;
  WeatherItem({
    this.id,
    this.name,
    this.region,
    this.country,
    required this.lat,
    required this.lon,
    this.url,
  });

  factory WeatherItem.fromJson(Map<String, dynamic> map) {
    return WeatherItem(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      region: map['region'] ?? '',
      country: map['country'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      url: map['url'] ?? '',
    );
  }

  @override
  bool operator ==(covariant WeatherItem other) =>
      identical(this, other) ||
      (id == other.id &&
          name == other.name &&
          region == other.region &&
          country == other.country &&
          lat == other.lat &&
          lon == other.lon &&
          url == other.url);

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        region,
        country,
        lat,
        lon,
        url,
      ]);
}
