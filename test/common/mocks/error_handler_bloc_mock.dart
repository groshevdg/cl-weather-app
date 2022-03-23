import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:mockito/mockito.dart';

class MockErrorHandlerBloc extends Mock implements ErrorHandlerBloc {
  @override
  void add(ErrorHandlerEvent? event) {
    super.noSuchMethod(Invocation.method(#start, [event]));
  }
}
