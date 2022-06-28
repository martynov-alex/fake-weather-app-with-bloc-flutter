import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_with_bloc/data/model/weather.dart';
import 'package:weather_app_with_bloc/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(const WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      try {
        emit(const WeatherLoading());
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } on NetworkException {
        emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
      }
    });
  }
}
