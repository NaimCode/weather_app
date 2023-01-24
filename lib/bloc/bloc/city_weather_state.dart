// ignore_for_file: must_be_immutable

part of 'city_weather_bloc.dart';

@immutable
abstract class CityWeatherState {}

class CityWeatherInitial extends CityWeatherState {}

class CityWeatherData extends CityWeatherState {
   List<CityWeather> cityWeathers;
   CityWeatherData({
    required this.cityWeathers,
  });

}

class CityWeatherLoading extends CityWeatherState{

}

class CityWeatherError extends CityWeatherState{

}