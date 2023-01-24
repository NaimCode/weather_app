// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather {
    Weather({
        this.cod,
        this.message,
        this.cnt,
        this.list,
        this.city,
    });

    final String? cod;
    final int? message;
    final int? cnt;
    final List<ListElement?>? list;
    final City? city;

    

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list:  List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        city:  City.fromJson(json["city"]),
    );

   
}

class City {
    City({
         this.id,
         this.name,
         this.coord,
         this.country,
         this.population,
         this.timezone,
         this.sunrise,
         this.sunset,
    });

    final int? id;
    final String? name;
    final Coord? coord;
    final String? country;
    final int? population;
    final int? timezone;
    final int? sunrise;
    final int? sunset;

   

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord:  Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

}

class Coord {
    Coord({
        required this.lat,
        required this.lon,
    });

    final double lat;
    final double lon;

   

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat:  json["lat"].toDouble(),
        lon:  json["lon"].toDouble(),
    );

}

class ListElement {
    ListElement({
         this.dt,
         this.main,
         this.weather,
         this.clouds,
         this.wind,
         this.visibility,
         this.pop,
         this.sys,
         this.dtTxt,
         this.rain,
         this.snow,
    });

    final int? dt;
    final MainClass? main;
    final List<WeatherElement?>? weather;
    final Clouds? clouds;
    final Wind? wind;
    final int? visibility;
    final double? pop;
    final Sys? sys;
    final DateTime? dtTxt;
    final Rain? rain;
    final Rain? snow;

    

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
         main:  MainClass.fromJson(json["main"]),
         weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromJson(x))),
         clouds:  Clouds.fromJson(json["clouds"]),
         wind:  Wind.fromJson(json["wind"]),
         visibility: json["visibility"],
         pop:  json["pop"].toDouble(),
         sys:  Sys.fromJson(json["sys"]),
        dtTxt:  DateTime.parse(json["dt_txt"]),
        //
        rain:json["rain"]==null?null:  Rain.fromJson(json["rain"]),
        snow: json["snow"]==null?null: Rain.fromJson(json["snow"]),
    );

   
}

class Clouds {
    Clouds({
         this.all,
    });

    final int? all;



    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class MainClass {
    MainClass({
         this.temp,
         this.feelsLike,
         this.tempMin,
         this.tempMax,
         this.pressure,
         this.seaLevel,
         this.grndLevel,
         this.humidity,
         this.tempKf,
    });

    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final int? pressure;
    final int? seaLevel;
    final int? grndLevel;
    final int? humidity;
    final double? tempKf;

   

    factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin:  json["temp_min"].toDouble(),
        tempMax:  json["temp_max"].toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf:  json["temp_kf"].toDouble(),
    );

   
}

class Rain {
    Rain({
         this.the3H,
    });

    final double? the3H;



    factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H:json["3h"]==null?null:  json["3h"].toDouble(),
    );

}

class Sys {
    Sys({
        this.pod,
    });

    final Pod? pod;


    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"] == null ? null : podValues.map![json["pod"]],
    );


}

enum Pod { N, D }

final podValues = EnumValues({
    "d": Pod.D,
    "n": Pod.N
});

class WeatherElement {
    WeatherElement({
       this.id,
       this.main,
       this.description,
       this.icon,
    });

    final int? id;
    final MainEnum? main;
    final String? description;
    final String? icon;



    factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: null,//json["main"] == null ? null : mainEnumValues.map![json["main"]],
        description: json["description"],
        icon: json["icon"],
    );

   
}

// ignore: constant_identifier_names
enum MainEnum { CLOUDS, RAIN, SNOW }

final mainEnumValues = EnumValues({
    "Clouds": MainEnum.CLOUDS,
    "Rain": MainEnum.RAIN,
    "Snow": MainEnum.SNOW
});

class Wind {
    Wind({
       this.speed,
       this.deg,
       this.gust,
    });

    final double? speed;
    final int? deg;
    final double? gust;

    
    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust:  json["gust"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}

class EnumValues<T> {
    Map<String, T>? map;
   late Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap =map==null?null: map!.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
