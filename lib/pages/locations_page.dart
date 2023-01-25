import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/widget/layout_background.dart';

import '../Config/theme.dart';
import '../bloc/bloc/city_weather_bloc.dart';
import '../model/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late List<CityWeather> cities;
  bool isLoading=false;
  @override
  void initState() {
    super.initState();
    Hive.box('location');
    CityWeatherState state = BlocProvider.of<CityWeatherBloc>(context).state;
    if (state is! CityWeatherData) {
      Get.back();
      cities=[];
    } else {
      cities = [...state.cityWeathers];
    }
  }

  void onAddLocation() async {
    Location location = await Get.toNamed("/search_location");
    var box = Hive.box('location');
    print("before : ${box.values.length}");
    box.add(location);
    List<Location> boxValues = box.values.cast<Location>().toList();
    print("before : ${boxValues.length}");
    BlocProvider.of<CityWeatherBloc>(context)
        .add(CityWeatherLocations(locations: boxValues));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBackground(
        content: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Villes'),
      ),
      
      body: BlocListener<CityWeatherBloc, CityWeatherState>(
        listener: (context, state) {

           if(state is CityWeatherLoading){
          setState(() {
            isLoading=true;
          });
           }
           if(state is CityWeatherData){
            setState(() {
             isLoading=false;
              cities=state.cityWeathers;
            });
           }
        },
        child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) => LocationItem(
                  item: cities[index],
                  index: index,
                )),
      ),
    ));
  }
}

class LocationItem extends StatefulWidget {
  final CityWeather item;
  final int index;
  const LocationItem({super.key, required this.item, required this.index});

  @override
  State<LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  void onRemoveLocation() async {
    bool remove = await Get.toNamed("/home?indexWeather=${widget.index}");
   if(remove==true){
     var box = Hive.box('location');
   box.deleteAt(widget.index);
    List<Location> boxValues = box.values.cast<Location>().toList();

    BlocProvider.of<CityWeatherBloc>(context)
        .add(CityWeatherLocations(locations: boxValues));
    setState(() {});
   }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onRemoveLocation,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 180,
        decoration: BoxDecoration(
            color: accent3,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: primary.withOpacity(.7),
                ),
                const SizedBox(width: 5),
                Text(
                  "${widget.item.currentWeather!.name!}, ${widget.item.currentWeather!.sys!.country!}",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                Text(
                  DateFormat.MMMMEEEEd().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.item.currentWeather!.dt! * 1000)),
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.item.currentWeather!.main!.temp!.toStringAsFixed(0),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(' °C',
                      style: TextStyle(
                          color: primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Container()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      getIcon(icon: widget.item.currentWeather!.weather![0]!.icon!),
                      scale: 0.7,
                    ),
                  ],
                )
              ],
            ),
            Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.blue.shade100,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat.Hm().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (widget.item.currentWeather!.dt!) * 1000)),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
