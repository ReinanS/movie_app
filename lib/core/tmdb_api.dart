import 'package:dio/dio.dart';

class TmdbApi {
  static String requestImage(String img) =>
      'https://image.tmdb.org/t/p/w500/$img';

  static final kBaseUrl = 'https://api.themoviedb.org/3';
  static final kApiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiN2VjNDE4NTNiZTI4NTE0OTQ3YmM2ODRiMTYxMDAwMSIsInN1YiI6IjYxOTAxYzgxZDc1YmQ2MDA2NDQwNjExNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rIfcRo5grKLiuXKHszbsowp0N8LYrtDgKF4Of7v6svk';

  static final kServerError =
      'Failed to connect to the server. Try again later.';
  static final kDioOptions = BaseOptions(
    baseUrl: kBaseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/json;charset=utf-8',
    headers: {'Authorization': 'Bearer $kApiKey'},
  );
}
