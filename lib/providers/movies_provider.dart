import 'dart:async';

import 'package:app_movie/helpers/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Todo: Import from models => Dev
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "36002ce4e93587a375e2194373c1671d";
  final String _language = "es-ES";

  List<Movie> getMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  // Todo: Increment page for scroll
  int _popularPage = 0;

  //Todo: Implement debouncer.
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  //Todo: Implement stream.
  final StreamController<List<Movie>> _stream = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _stream.stream;

  // Todo: constructor
  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

// Todo: Function for
  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoint, {
      "api_key": _apiKey,
      "language": _language,
      "page": "$page",
    });

    final response = await http.get(url);
    return response.body;
  }

  getNowPlayingMovies() async {
    final resp = await _getJsonData("3/movie/now_playing");
    final nowPlaying = NowPlayingResponse.fromJson(resp);
    getMovies = nowPlaying.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final resp = await _getJsonData("3/movie/popular", _popularPage);
    final popular = PopularResponse.fromJson(resp);
    popularMovies = [...popularMovies, ...popular.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    // Todo: Verifico si los actores están cargados en la memoria.
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    // Todo: sino existe realiza la petición.
    final resp = await _getJsonData("3/movie/$movieId/credits");
    final creditsResponse = CreditResponse.fromJson(resp);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie", {
      "api_key": _apiKey,
      "language": _language,
      "query": query,
    });

    final resp = await http.get(url);
    final searchResp = SearchResponse.fromJson(resp.body);
    return searchResp.results;
  }

  // Todo: Push query(work) in streams
  void getSuggestionByQuery(String query) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final resp = await searchMovie(value);
      _stream.add(resp);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301)).then(
      (_) => timer.cancel(),
    );
  }
}
