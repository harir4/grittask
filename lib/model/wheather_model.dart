class Weather {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String localTime;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final String conditionText;
  final String conditionIcon;

  Weather({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localTime,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.conditionText,
    required this.conditionIcon,
  });

  factory Weather.fromJson(Map<String, dynamic> map) {
    return Weather(
      name: map['location']['name'] ?? '',
      region: map['location']['region'] ?? '',
      country: map['location']['country'] ?? '',
      lat: map['location']['lat']?.toDouble() ?? 0.0,
      lon: map['location']['lon']?.toDouble() ?? 0.0,
      localTime: map['location']['localtime'] ?? '',
      lastUpdated: map['current']['last_updated'] ?? '',
      tempC: map['current']['temp_c']?.toDouble() ?? 0.0,
      tempF: map['current']['temp_f']?.toDouble() ?? 0.0,
      conditionText: map['current']['condition']['text'] ?? '',
      conditionIcon: map['current']['condition']['icon'] ?? '',
    );
  }
}
