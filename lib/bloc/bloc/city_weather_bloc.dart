import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'city_weather_event.dart';
part 'city_weather_state.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  WeatherRepository weatherRepository;
  CityWeatherBloc({required this.weatherRepository}) : super(CityWeatherInitial()) {
    on<CityWeatherLocations>((event, emit) async{
      print(event.locations.map((e) => e.name));
      emit(CityWeatherLoading());
      try {
        List<CityWeather> data=await weatherRepository.getWeathers(locations: event.locations);
        emit(CityWeatherData(cityWeathers: data));
      } catch (e) {
        print(e.toString());
        emit(CityWeatherError());
      }
    });
  }
}
