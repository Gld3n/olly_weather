class Weather {
  final String country;
  final double tempC;
  final double tempF;
  final double feelsLikeC;
  final double feelsLikeF;
  final String conditionText;
  final String conditionIcon;
  final double windMph;
  final double windDegree;
  final int humidityPercentage;

  const Weather({
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.conditionText,
    required this.conditionIcon,
    required this.windMph,
    required this.windDegree,
    required this.humidityPercentage,
  });

  @override
  String toString() {
    return 'Weather{country: $country, tempC: $tempC, tempF: $tempF, feelsLikeC: $feelsLikeC, feelsLikeF: $feelsLikeF, condition: $conditionText, windMph: $windMph, windDegree: $windDegree, humidityPercentage: $humidityPercentage}';
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    // I used the map-access version because of nested fields flexibility.
    // toType methods were used to ensure type-safety against an unknown data provider.
    final location = json['location'] as Map<String, dynamic>;
    final current = json['current'] as Map<String, dynamic>;
    return Weather(
      country: location['country'] as String,
      tempC: (current['temp_c'] as num).toDouble(),
      tempF: (current['temp_f'] as num).toDouble(),
      feelsLikeC: (current['feelslike_c'] as num).toDouble(),
      feelsLikeF: (current['feelslike_f'] as num).toDouble(),
      conditionText: (current['condition']?['text'] ?? '') as String,
      conditionIcon: (current['condition']?['icon'] ?? '') as String,
      windMph: (current['wind_mph'] as num).toDouble(),
      windDegree: (current['wind_degree'] as num).toDouble(),
      humidityPercentage: (current['humidity'] as num).toInt(),
    );
  }
}
