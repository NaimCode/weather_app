import 'package:dio/dio.dart';

import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/location.dart';


class WeatherRepository {
  Dio dio;
  WeatherRepository({
    required this.dio,
  });

  Future<List<CityWeather>> getWeathers(
      {required List<Location> locations}) async {
    List<CityWeather> result = [];
    for (Location l in locations) {
      var responses = await Future.wait([
        dio.get(
            'https://api.openweathermap.org/data/2.5/weather?lat=${l.lat}&lon=${l.lon}&units=metric&appid=642e850440ff7034d40a389ac216c668&lang=fr'),
        // dio.get(
        //     'https://api.openweathermap.org/data/2.5/forecast?lat=${l.lat}&lon=${l.lon}&units=metric&appid=642e850440ff7034d40a389ac216c668&lang=fr')
      ]); 
  
      if (responses[0].statusCode == 200 ) {
        CurrentWeather currentWeather = CurrentWeather.fromJson(responses[0].data);

        result
            .add(CityWeather(currentWeather: currentWeather));
      }
    }

    return result;
  }

   
  
 // http://api.openweathermap.org/geo/1.0/direct?q=raba&appid=a6f8a10c4eef20ebf09668f9b2956379&lang=fr

}
