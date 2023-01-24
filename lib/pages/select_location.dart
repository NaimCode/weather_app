import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Config/theme.dart';

import '../bloc/bloc/city_weather_bloc.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Lottie.asset("assets/splash.json"),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Container()),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Weather ",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' News & Feed',
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      BlocBuilder<CityWeatherBloc, CityWeatherState>(
                        builder: (context, state) {
                          if (state is CityWeatherLoading) {
                            return SpinKitRing(
                              color: primary,
                              size: 30.0,
                            );
                          }
                          if (state is CityWeatherError) {
                       
                            return const Text(
                              'Erreur lors de la recupération des données',
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            );
                          }
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () => Get.toNamed("/locations"),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 13),
                                child: Text(
                                  'Get Started',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
