// ignore_for_file: must_be_immutable

part of 'city_weather_bloc.dart';

@immutable
abstract class CityWeatherEvent {}

class CityWeatherLocations extends CityWeatherEvent {
  List<Location> locations;
  CityWeatherLocations({
    required this.locations,
  });
  
}
