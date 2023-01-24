import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Config/theme.dart';
import 'package:weather_app/bloc/bloc/city_weather_bloc.dart';
import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/widget/chart.dart';
import 'package:weather_app/widget/layout_background.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../model/weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String getIcon({required String icon}) {
  return "https://openweathermap.org/img/w/$icon.png";
}

class _HomeState extends State<Home> {
  late CityWeather cityWeather;
  late List<ListElement?> todayEls;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    int? index = int.tryParse(Get.parameters['indexWeather']!);

    CityWeatherState state = BlocProvider.of<CityWeatherBloc>(context).state;
    if (index == null || state is! CityWeatherData) {
      Get.back();
    } else {
      cityWeather = state.cityWeathers[index];
      todayEls = cityWeather.getToday();
    }
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
        title: const Text('Weather Forecast'),
        leading: IconButton(
            splashRadius: 25,
            onPressed: () => Get.back(result: false),
            icon: const Icon(
              Icons.dashboard_outlined,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              splashRadius: 25,
              onPressed: () => Get.back(result: true),
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: 250,
              decoration: BoxDecoration(
                  color: accent3,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Aujourd'hui",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        DateFormat.MMMMEEEEd().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                cityWeather.currentWeather!.dt! * 1000)),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          cityWeather.currentWeather!.main!.temp!
                              .toStringAsFixed(0),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(' °C',
                            style: TextStyle(
                                color: primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            getIcon(
                                icon: cityWeather
                                    .currentWeather!.weather![0]!.icon!),
                            scale: 0.7,
                          ),
                          Text(
                            cityWeather
                                .currentWeather!.weather![0]!.description!,
                            style: TextStyle(color: Colors.amber.shade100),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: primary.withOpacity(.7),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${cityWeather.currentWeather!.name!}, ${cityWeather.currentWeather!.sys!.country!}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Aujourd'hui",
                        style: TextStyle(color: Colors.amber),
                      )),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () => Get.toNamed("/weathers?type=tomorrow",
                          arguments: cityWeather.getTomorrow()),
                      child: const Text(
                        "Demain",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () => Get.toNamed("/weathers?type=5days",
                          arguments: cityWeather.weather!.list!),
                      child: const Text(
                        "Prochain 5 jours",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(width: 10)
                ],
              ),
            ),
            SizedBox(
                height: 120,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: todayEls.length,
                    itemBuilder: (context, index) =>
                        WeatherItem(item: todayEls[index]))),
            const SizedBox(height: 20),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LineChartSample2(),
            ))
          ],
        ),
      ),
    ));
  }
}

class WeatherItem extends StatelessWidget {
  final ListElement? item;
  const WeatherItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: accent3, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            getIcon(icon: item!.weather![0]!.icon!),
          ),
          Text(
            DateFormat.H()
                .format(DateTime.fromMillisecondsSinceEpoch(item!.dt! * 1000)),
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item!.main!.temp!.toStringAsFixed(0),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(' °C',
                    style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
