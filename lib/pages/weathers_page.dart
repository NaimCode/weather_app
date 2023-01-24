import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Config/theme.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/widget/layout_background.dart';

import 'home.dart';

class WeathersPage extends StatefulWidget {
  const WeathersPage({super.key});

  @override
  State<WeathersPage> createState() => _WeathersPageState();
}

class _WeathersPageState extends State<WeathersPage> {
  late List<ListElement> weathers;
  @override
  void initState() {
    weathers=Get.arguments;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String title =
        Get.parameters['type'] == 'tomorrow' ? "Demain" : "Prochain 5 jours";
    return LayoutBackground(
        content: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(title),
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        bool hasDay=false;
        bool isAuj=false;
        if(index==0){
          hasDay=true;
          if(DateTime.fromMillisecondsSinceEpoch(weathers[index].dt! * 1000).day==DateTime.now().day){
            isAuj=true;
          }
        }else{
          var yesder=DateTime.fromMillisecondsSinceEpoch(weathers[index-1].dt! * 1000).day;
          var day=DateTime.fromMillisecondsSinceEpoch(weathers[index].dt! * 1000).day;

          if( yesder!=day){
            hasDay=true;
          }
        }

        return WeatherItem(item: weathers[index],hasDay:hasDay,isAuj: isAuj);
      }, separatorBuilder: (context, index) => const Divider(), itemCount: weathers.length),
      backgroundColor: Colors.transparent,
    ),
  );
  }
}


class WeatherItem extends StatelessWidget {
  final ListElement? item;
  final bool hasDay;
  final bool isAuj;
  const WeatherItem({super.key, required this.item,required this.hasDay,required this.isAuj});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: hasDay,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(isAuj?"Aujourd'hui":DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(item!.dt! * 1000)),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700, fontSize: 18),),
          )),
      ListTile(tileColor: accent3,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,children: [
         Text(
              DateFormat.H().format(
                  DateTime.fromMillisecondsSinceEpoch(item!.dt! * 1000)),
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
            getIcon(icon: item!.weather![0]!.icon!),
         
            
          ),
             Text(
                            item!.weather![0]!.description!,
                            style: const TextStyle(color: Colors.white60),
                          )
                  ],
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
        // Text(DateFormat('EEEE').format(
        //           DateTime.fromMillisecondsSinceEpoch(item!.dt! * 1000)),style: const TextStyle(color: Colors.white),)
      ],),
    )
    ],);
  }
}
