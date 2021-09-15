// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/config.dart';
import 'package:flutter_demo/models/movie_details.dart';
import 'package:flutter_demo/pages/popular_movies.dart';
import 'package:flutter_demo/services/movie_service.dart';
import 'package:flutter_demo/widgets/movie_details_widget.dart';

class MovieDetailsPage extends StatefulWidget {
  final String id;
  const MovieDetailsPage(this.id);
  static const route = '/moviedetailspage';
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  Future<dynamic>? movieDetailData;
  Future<dynamic>? configData;
  final movieService = MovieService();
  Config? config;
  MovieDetails? movieDetails;

  getConfig() async {
    var response;
    try {
      response = await movieService.getConfiguration();
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
          content: Text('Error grabbing config',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  getMovieDetails(String id) async {
    var response;
    try {
      response = await movieService.getMovieDetails(id);
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
          content: Text('Error grabbing movie details',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Widget movieDetailsScreen() {
    Iterable<Future<dynamic>> futures = [movieDetailData!, configData!];
    return FutureBuilder(
      future: Future.wait(futures),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          movieDetails = snapshot.data![0];
          config = snapshot.data![1];
          return Scaffold(
            appBar: pageAppBar(movieDetails!.title),
            body: MovieDetailsWidget(
              movieDetails!.budget,
              movieDetails!.tagline,
              movieDetails!.overview,
              movieDetails!.releaseDate,
              movieDetails!.backdropPath,
              movieDetails!.genres,
              movieDetails!.popularity,
              movieDetails!.runtime,
              movieDetails!.voteAverage,
              movieDetails!.voteCount,
              movieDetails!.homepage,
              movieDetails!.posterPath,
              movieDetails!.title,
              movieDetails!.languages,
              config!.baseUrl,
              config!.logoSizes[5],
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: Colors.purple,
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget pageAppBar(String title) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacementNamed(context, PopularMoviesPage.route);
        },
      ),
      title: Text(title),
    );
  }

  @override
  void initState() {
    super.initState();
    movieDetailData = getMovieDetails(widget.id);
    configData = getConfig();
  }

  @override
  Widget build(BuildContext context) {
    return movieDetailsScreen();
  }
}
