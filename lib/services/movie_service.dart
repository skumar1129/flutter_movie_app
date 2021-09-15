// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_demo/models/config.dart';
import 'package:flutter_demo/models/movie_details.dart';
import 'package:flutter_demo/models/movie_images.dart';
import 'package:flutter_demo/models/popular_movies.dart';
import 'secrets.dart';

Config parseConfigResponse(dataItem) {
  return Config.fromJson(dataItem);
}

MovieDetails parseMovieDetailsResponse(dataItem) {
  return MovieDetails.fromJson(dataItem);
}

MovieImages parseMoveImageResponse(dataItem) {
  return MovieImages.fromJson(dataItem);
}

List<PopularMovies> parsePopularMoviesResponse(dataItems) {
  return dataItems
      .map<PopularMovies>((json) => PopularMovies.fromJson(json))
      .toList();
}

class MovieService {
  static const host = 'api.themoviedb.org';

  Future<Config> getConfiguration() async {
    var params = {'api_key': Secrets.apiKey};
    var endpoint = Uri.https(host, '/3/configuration', params);
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    var responseBody = json.decode(response.body);

    return compute(parseConfigResponse, responseBody['images']);
  }

  Future<MovieDetails> getMovieDetails(String id) async {
    var params = {'api_key': Secrets.apiKey};
    var endpoint = Uri.https(host, '/3/movie/$id', params);
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseMovieDetailsResponse, json.decode(response.body));
  }

  Future<MovieImages> getMovieImage(String id) async {
    var params = {'api_key': Secrets.apiKey};
    var endpoint = Uri.https(host, '/3/movie/$id/images', params);
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseMoveImageResponse, json.decode(response.body));
  }

  Future<List<PopularMovies>> getPopularMovies([int? page]) async {
    var params = {'api_key': Secrets.apiKey};
    var endpoint = Uri.https(host, '/3/movie/popular', params);
    if (page != null && page > 1) {
      params = {'page': page.toString(), 'api_key': Secrets.apiKey};
      endpoint = Uri.https(host, '/3/movie/popular', params);
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    var responseBody = json.decode(response.body);

    return compute(parsePopularMoviesResponse, responseBody['results']);
  }
}
