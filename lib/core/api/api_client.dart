import 'package:dio/dio.dart';

abstract class ApiClient {
  // GET request
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  // POST request
  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  });

  // PATCH request
  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  });

  // DELETE request
  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFromData = false,
  });
}
