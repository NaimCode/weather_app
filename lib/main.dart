// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Config/theme.dart';
import 'package:weather_app/bloc/bloc/city_weather_bloc.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/locations_page.dart';
import 'package:weather_app/repository/weather_repository.dart';

void main() async {
  await Hive.initFlutter();

  Intl.defaultLocale = 'fr_FR';
        initializeDateFormatting();
  
  Hive.registerAdapter(LocationAdapter());
  var box = await Hive.openBox('location');
  box.clear();
 //box.clear();
  if (box.isEmpty) {
    box.add(Location(
        lat: 34.020882,
        // 44.34,
        lon: -6.841650,
        // 10.99,
        name: "Rabat",
        id: 0));

            box.add(Location(
        lat: 35.7595,
        // 44.34,
        lon: -5.8340,
        // 10.99,
        name: "Tanger",
        id: 2));
            box.add(Location(
        lat: 35.0035,
        // 44.34,
        lon: -5.9155,
        // 10.99,
        name: "Ksar kbire",
        id: 3));
  }
  List<Location> locations = box.values.cast<Location>().toList();

  runApp(App(location: locations));
}

class App extends StatelessWidget {
  App({super.key, required this.location});
  List<Location> location;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
          BlocProvider(
              create: (context) => CityWeatherBloc(
                  weatherRepository: WeatherRepository(dio: Dio()))
                ..add(CityWeatherLocations(locations: location)))
        ],
  child: ValueListenableBuilder<Box>(
  valueListenable: Hive.box('location').listenable(),
  builder: (context, box, widget) {
    // build widget
   print('Add new Location');
  
    return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          
          theme: ThemeData(
            primarySwatch: primary,
          ),
          initialRoute: "/locations",
          getPages: [
         //   GetPage(name: "/", page: () => const SelectLocation()),
            GetPage(name: "/locations", page: () => const LocationPage()),
            GetPage(name: "/home", page: () => const Home()),
          ],
        );
  },
));
  }
}
