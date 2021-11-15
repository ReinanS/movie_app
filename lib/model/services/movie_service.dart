import 'dart:io';

import 'package:cubos_movies/view/utils/constansts.dart';
import 'package:cubos_movies/model/apis/app_exception.dart';
import 'package:cubos_movies/model/services/base_service.dart';
import 'package:http/http.dart' as http;

class MovieService extends BaseService {
  @override
  Future<dynamic> getResponse(String url) async {
    dynamic responseJson;

    final params = {
      "api_key": TmdbConstants.apiKey,
      "language": "pt-BR",
      "page": "1",
    };

    final String queryString = Uri(queryParameters: params).query;
    final String urlString = dbBaseUrl + url + '?' + queryString;

    try {
      final response = await http.get(Uri.parse(urlString));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e);
    }

    return responseJson;
  }

  @override
  Future<dynamic> getMoviesGenre(String url, int genreId) async {
    dynamic responseJson;

    final params = {
      "api_key": TmdbConstants.apiKey,
      "language": "pt-BR",
      "page": "1",
      "with_genres": genreId.toString(),
    };

    final String queryString = Uri(queryParameters: params).query;
    final String urlString = dbBaseUrl + url + '?' + queryString;

    try {
      final response = await http.get(Uri.parse(urlString));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e);
    }

    return responseJson;
  }
}