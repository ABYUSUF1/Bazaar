import 'failure.dart';
import 'package:dio/dio.dart';

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with API server');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with API server');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with API server');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request to API server was cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('No Internet connection');

      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again!');

      default:
        return ServerFailure('Opps something went wrong, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try again');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, Please try again');
    } else {
      return ServerFailure('Something went wrong, Please try again');
    }
  }
}
