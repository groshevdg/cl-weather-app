import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_state.dart';
import 'package:cl_weather_app/common/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorHandlerBloc extends Bloc<ErrorHandlerEvent, ErrorHandlerState> {
  ErrorHandlerBloc({
    required Logger logger,
  })  : _logger = logger,
        super(InitialErrorHandlerState()) {
    on<HandleErrorEvent>(_onHandleErrorEvent);
  }

  final Logger _logger;

  Future<void> _onHandleErrorEvent(
    HandleErrorEvent event,
    Emitter emit,
  ) async {
    if (event.error is DioError) {
      await _handleDioError(emit, event.error as DioError, event.stackTrace);
    } else {
      await _handleUnknownError(emit, event.error, event.stackTrace);
    }
  }

  Future<void> _handleDioError(
    Emitter emit,
    DioError error,
    StackTrace stackTrace,
  ) async {
    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout ||
        error.type == DioErrorType.sendTimeout) {
      emit(TimeoutErrorState());
    } else if (error.type == DioErrorType.response) {
      await _handleDioResponseError(emit, error, stackTrace);
    } else {
      await _handleUnknownError(emit, error, stackTrace);
    }
  }

  Future<void> _handleDioResponseError(
    Emitter emit,
    DioError error,
    StackTrace stackTrace,
  ) async {
    final statusCode = error.response!.statusCode;
    switch (statusCode) {
      case 400:
        emit(ValidationErrorState());
        break;
      case 403:
        emit(ForbiddenErrorState());
        break;
      case 404:
        emit(NotFoundErrorState());
        break;
      case 500:
        emit(InternalServerErrorState());
        break;
      default:
        await _handleUnknownError(emit, error, stackTrace);
    }
  }

  Future<void> _handleUnknownError(Emitter emit, Object e, StackTrace s) async {
    _logger.e(
      message: 'Unknown error handled in ErrorHandlerBloc',
      error: e,
      stackTrace: s,
    );
    emit(UnknownErrorState());
  }
}
