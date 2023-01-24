import 'package:weather_app/model/weather.dart';

import 'current_weather.dart';

class CityWeather {
  Weather? weather;
  CurrentWeather? currentWeather;
  CityWeather({
    this.weather,
    this.currentWeather,
  });

  CityWeather copyWith({
    Weather? weather,
    CurrentWeather? currentWeather,
  }) {
    return CityWeather(
      weather: weather ?? this.weather,
      currentWeather: currentWeather ?? this.currentWeather,
    );
  }

  int getDay({required int dt}) {
    return DateTime.fromMillisecondsSinceEpoch(dt * 1000).day;
  }

  List<ListElement?> getToday() {
    int today = getDay(dt: currentWeather!.dt!);
    return weather!.list!
        .where((element) => getDay(dt: element!.dt!) == today)
        .toList();
  }
    List<ListElement?> getTomorrow() {
    int today = getDay(dt: currentWeather!.dt!)+1;
    return weather!.list!
        .where((element) => getDay(dt: element!.dt!) == today)
        .toList();
  }
}
