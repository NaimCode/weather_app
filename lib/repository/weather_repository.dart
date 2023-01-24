import 'package:dio/dio.dart';

import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/geo_code.dart';
import 'package:weather_app/model/location.dart';

import '../model/weather.dart';

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
            'https://api.openweathermap.org/data/2.5/weather?lat=${l.lat}&lon=${l.lon}&units=metric&appid=a6f8a10c4eef20ebf09668f9b2956379&lang=fr'),
        dio.get(
            'https://api.openweathermap.org/data/2.5/forecast?lat=${l.lat}&lon=${l.lon}&units=metric&appid=a6f8a10c4eef20ebf09668f9b2956379&lang=fr')
      ]); 
  
      if (responses[0].statusCode == 200 && responses[1].statusCode == 200) {
        CurrentWeather currentWeather = CurrentWeather.fromJson(responses[0].data);
       Weather weather = Weather.fromJson(responses[1].data);
        result
            .add(CityWeather(currentWeather: currentWeather,weather: weather));
      }
    }

    return result;
  }

    Future<List<GeoCode>> getGeoCode(
      {required String query}) async {
    List<GeoCode> result = [];
   
      var responses = await  dio.get(
            'http://api.openweathermap.org/geo/1.0/direct?q=$query&appid=a6f8a10c4eef20ebf09668f9b2956379&lang=fr&limit=10');
  
      if (responses.statusCode == 200) {
     var list= responses.data;
       List<GeoCode> listGeo=List<GeoCode>.from(list.map((r)=>GeoCode.fromJson(r)).toList());

       for (GeoCode geo in listGeo) {
         if(result.where((element) => element.name==geo.name && element.country==geo.country&& element.state==geo.state).toList().isEmpty && geo.lat!=null && geo.lon!=null && geo.name!=null){
          result.add(geo);
         }
       }
      }else{
        print(responses.statusMessage);
      }

    return result;
  }
  
 // http://api.openweathermap.org/geo/1.0/direct?q=raba&appid=a6f8a10c4eef20ebf09668f9b2956379&lang=fr

}
