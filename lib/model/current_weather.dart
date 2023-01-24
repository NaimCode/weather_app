// To parse this JSON data, do
//
//     final currentWeather = currentWeatherFromJson(jsonString);

import 'dart:convert';

CurrentWeather currentWeatherFromJson(String str) => CurrentWeather.fromJson(json.decode(str));

class CurrentWeather {
    CurrentWeather({
        required this.coord,
        required this.weather,
        required this.base,
        required this.main,
        required this.visibility,
        required this.wind,
        required this.clouds,
        required this.dt,
        required this.sys,
        required this.timezone,
        required this.id,
        required this.name,
        required this.cod,
    });

    final Coord? coord;
    final List<WeatherMini?>? weather;
    final String? base;
    final Main? main;
    final int? visibility;
    final Wind? wind;
    final Clouds? clouds;
    final int? dt;
    final Sys? sys;
    final int? timezone;
    final int? id;
    final String? name;
    final int? cod;


    factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        weather: json["weather"] == null ? null : List<WeatherMini>.from(json["weather"].map((x) => WeatherMini.fromJson(x))),
        base: json["base"],
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
    );

    
}

class Clouds {
    Clouds({
        required this.all,
    });
    final int? all;
    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class Coord {
    Coord({
        required this.lon,
        required this.lat,
    });

    final double lon;
    final double lat;
    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon:  json["lon"].toDouble(),
        lat:  json["lat"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class Main {
    Main({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.humidity,
        required this.seaLevel,
        required this.grndLevel,
    });

    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final int? pressure;
    final int? humidity;
    final int? seaLevel;
    final int? grndLevel;


    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp:  json["temp"].toDouble(),
        feelsLike:json["feels_like"]==null?null: json["feels_like"].toDouble(),
        tempMin:json["temp_min"]==null?null:  json["temp_min"].toDouble(),
        tempMax: json["temp_min"]==null?null: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
    };
}

class Sys {
    Sys({
        required this.type,
        required this.id,
        required this.country,
        required this.sunrise,
        required this.sunset,
    });

    final int? type;
    final int? id;
    final String? country;
    final int? sunrise;
    final int? sunset;

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json["type"],
        id: json["id"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class WeatherMini {
    WeatherMini({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    final int? id;
    final String? main;
    final String? description;
    final String? icon;



    factory WeatherMini.fromJson(Map<String, dynamic> json) => WeatherMini(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Wind {
    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    final double? speed;
    final int? deg;
    final double? gust;

   

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed:json["speed"]==null?null:  json["speed"].toDouble(),
        deg: json["deg"],
        gust:json["gust"] ==null?null: json["gust"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}
