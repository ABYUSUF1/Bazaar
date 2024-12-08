import 'package:bazaar/core/api/end_points.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl, // Set your base URL
    );

    // Add interceptors if needed ...
  }

  Future<Response> _request(
    String method,
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  }) async {
    try {
      final Response response = await _dio.request(
        path,
        data: isFromData && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
        ),
      );
      return response; // Return response directly
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _request('GET', path,
        data: data, queryParameters: queryParameters, headers: headers);
  }

  @override
  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  }) {
    return _request('POST', path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        isFromData: isFromData);
  }

  @override
  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  }) {
    return _request('DELETE', path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        isFromData: isFromData);
  }

  @override
  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  }) {
    return _request('PATCH', path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        isFromData: isFromData);
  }
}
