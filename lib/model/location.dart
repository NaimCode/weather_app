import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'location.g.dart';

@HiveType(typeId: 1)
class Location {
  @HiveField(0)
     int id;
  @HiveField(1)
  String name;
   @HiveField(2)
  double lat;
   @HiveField(3)
   double lon;


  Location({
    required this.lat,
    required this.lon,
    required this.name,
    required this.id,
  });

  Location copyWith({
    double? lat,
    double? lon,
    String? name,
    int? id,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lon': lon,
      'name': name,
      'id': id,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(lat: $lat, lon: $lon, name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Location &&
      other.lat == lat &&
      other.lon == lon &&
      other.name == name &&
      other.id == id;
  }

  @override
  int get hashCode {
    return lat.hashCode ^
      lon.hashCode ^
      name.hashCode ^
      id.hashCode;
  }
}
