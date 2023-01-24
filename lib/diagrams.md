classDiagram
   class CityWeather {

   }
   class Weather{
    final int? id;
    final String? name;
    final String? country;
    final int? population;
    final int? timezone;
    final int? sunrise;
    final int? sunset;
   }
   class Coord {

    final double lat
    final double lon


}
class GeoCode {
  

    final String? name;
    final LocalNames? localNames;
    final double? lat;
    final double? lon;
    final String? country;
    final String? state;


}

class Clouds {

    final int? all

}
class Main {


    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final int? pressure;
    final int? seaLevel;
    final int? grndLevel;
    final int? humidity;
    final double? tempKf;

   
}
CurrentWeather <|-- Coord
CurrentWeather <|-- Clouds
CurrentWeather <|-- Main
Weather <|-- Coord
Weather <|-- Clouds
Weather <|-- Main
Weather <|-- GeoCode
   class CurrentWeather{
    
    final List<WeatherMini?>? weather;
    final String? base;
    final int? visibility;
    final Wind? wind;
    final int? dt;
    final Sys? sys;
    final int? timezone;
    final int? id;
    final String? name;
    final int? cod;
   }


   CityWeather <-- Weather
   CityWeather <-- CurrentWeather
class Location {
     int id;
  String name;
  double lat;
   double lon;



}

   