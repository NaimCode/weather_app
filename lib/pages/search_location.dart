import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app/Config/theme.dart';
import 'package:weather_app/model/geo_code.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/widget/layout_background.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  TextEditingController search = TextEditingController();
  String text = "";
  WeatherRepository weatherRepository = WeatherRepository(dio: Dio());
  @override
  Widget build(BuildContext context) {
    return LayoutBackground(
        content: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          onChanged: (value) {
            EasyDebounce.debounce(
                'search', // <-- An ID for this particular debouncer
                const Duration(milliseconds: 500), // <-- The debounce duration
                () {
              setState(() {
                text = value;
              });
            } // <-- The target method
                );
          },
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.white60),
              hintText: "Chercher une ville",
              border: InputBorder.none),
          autofocus: true,
        ),
      ),
      body: text.isEmpty
          ? Container()
          : FutureBuilder<List<GeoCode>>(
              future: weatherRepository.getGeoCode(query: text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.white54,
                      size: 40.0,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text(
                    "Erreur rencontré",
                    style: TextStyle(color: Colors.red.shade300),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        GeoCode geo = snapshot.data![index];
                        return GeoItem(geo: geo);
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data!.length);
                }
                return Container();
              }),
    ));
  }
}

class GeoItem extends StatelessWidget {
  const GeoItem({
    Key? key,
    required this.geo,
  }) : super(key: key);

  final GeoCode geo;

  @override
  Widget build(BuildContext context) {
    String? name=geo.localNames!=null?geo.localNames!.fr ?? geo.name:geo.name;
    return ListTile(
      onTap: (){
        Get.back(result: Location(lat: geo.lat!, lon: geo.lon!, name: geo.name!, id: DateTime.now().millisecondsSinceEpoch));
      },
      subtitle: geo.state==null?null:Text(geo.state!,style: const TextStyle(color: Colors.white54),),
      leading: Icon(Icons.location_on_outlined,color: primary,),
      title: Text(name==null?"":name +(geo.country==null?"":", ${geo.country}"),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),));
  }
}
