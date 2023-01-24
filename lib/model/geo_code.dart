// To parse this JSON data, do
//
//     final geoCode = geoCodeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GeoCode geoCodeFromJson(String str) => GeoCode.fromJson(json.decode(str));

String geoCodeToJson(GeoCode data) => json.encode(data.toJson());

class GeoCode {
    GeoCode({
        @required this.name,
        @required this.localNames,
        @required this.lat,
        @required this.lon,
        @required this.country,
        @required this.state,
    });

    final String? name;
    final LocalNames? localNames;
    final double? lat;
    final double? lon;
    final String? country;
    final String? state;

    
    factory GeoCode.fromJson(Map<String, dynamic> json) => GeoCode(
        name: json["name"] ?? null,
        localNames: json["local_names"] == null ? null : LocalNames.fromJson(json["local_names"]),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        country: json["country"] ?? null,
        state: json["state"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "name": name ?? null,
        "local_names": localNames == null ? null : localNames!.toJson(),
        "lat": lat ?? null,
        "lon": lon ?? null,
        "country": country ?? null,
        "state": state ?? null,
    };
}

class LocalNames {
    LocalNames({
        @required this.ar,
        @required this.ur,
        @required this.he,
        @required this.de,
        @required this.es,
        @required this.fa,
        @required this.en,
        @required this.pl,
        @required this.ml,
        @required this.et,
        @required this.ru,
        @required this.fr,
        @required this.lt,
    });

    final String? ar;
    final String? ur;
    final String? he;
    final String? de;
    final String? es;
    final String? fa;
    final String? en;
    final String? pl;
    final String? ml;
    final String? et;
    final String? ru;
    final String? fr;
    final String? lt;

    
    factory LocalNames.fromJson(Map<String, dynamic> json) => LocalNames(
        ar: json["ar"] ?? null,
        ur: json["ur"] ?? null,
        he: json["he"] ?? null,
        de: json["de"] ?? null,
        es: json["es"] ?? null,
        fa: json["fa"] ?? null,
        en: json["en"] ?? null,
        pl: json["pl"] ?? null,
        ml: json["ml"] ?? null,
        et: json["et"] ?? null,
        ru: json["ru"] ?? null,
        fr: json["fr"] ?? null,
        lt: json["lt"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "ar": ar ?? null,
        "ur": ur ?? null,
        "he": he ?? null,
        "de": de ?? null,
        "es": es ?? null,
        "fa": fa ?? null,
        "en": en ?? null,
        "pl": pl ?? null,
        "ml": ml ?? null,
        "et": et ?? null,
        "ru": ru ?? null,
        "fr": fr ?? null,
        "lt": lt ?? null,
    };
}
