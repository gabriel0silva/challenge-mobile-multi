abstract interface class RestClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
  // Future<dynamic> post(String url, {dynamic data});
  // Future<dynamic> put(String url, {dynamic data});
  // Future<dynamic> delete(String url, {dynamic data});
}