import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/repositories/repositories.dart';
import 'package:meta/meta.dart';

abstract class WeatherDetailEvent extends Equatable {
  WeatherDetailEvent([List props = const []]) : super(props);
}

class FetchWeatherDetail extends WeatherDetailEvent {
  final int locationId;

  FetchWeatherDetail({@required this.locationId})
      : assert(locationId != null),
        super([locationId]);
}

class RefreshWeatherDetail extends WeatherDetailEvent {
  final int locationId;

  RefreshWeatherDetail({@required this.locationId})
      : assert(locationId != null),
        super([locationId]);
}

abstract class WeatherDetailState extends Equatable {
  WeatherDetailState([List props = const []]) : super(props);
}

class WeatherDetailEmpty extends WeatherDetailState {}

class WeatherDetailLoading extends WeatherDetailState {}

class WeatherDetailLoaded extends WeatherDetailState {
  final WeatherDetail weatherDetail;

  WeatherDetailLoaded({@required this.weatherDetail})
      : assert(weatherDetail != null),
        super([weatherDetail]);
}

class WeatherDetailError extends WeatherDetailState {}

class WeatherDetailBloc extends Bloc<WeatherDetailEvent, WeatherDetailState> {
  final WeatherRepository weatherRepository;

  WeatherDetailBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherDetailState get initialState => WeatherDetailEmpty();

  @override
  Stream<WeatherDetailState> mapEventToState(WeatherDetailEvent event) async* {
    if (event is FetchWeatherDetail) {
      yield WeatherDetailLoading();
      try {
        final WeatherDetail weatherDetail = await weatherRepository.getWeatherDetail(event.locationId);
        yield WeatherDetailLoaded(weatherDetail: weatherDetail);
      } catch (_) {
        yield WeatherDetailError();
      }
    }

    if (event is RefreshWeatherDetail) {
      try {
        final WeatherDetail weatherDetail = await weatherRepository.getWeatherDetail(event.locationId);
        yield WeatherDetailLoaded(weatherDetail: weatherDetail);
      } catch (_) {
        yield currentState;
      }
    }
  }
}
