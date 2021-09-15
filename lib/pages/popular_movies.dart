// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/config.dart';
import 'package:flutter_demo/models/popular_movies.dart';
import 'package:flutter_demo/services/movie_service.dart';
import 'package:flutter_demo/widgets/popular_movies_widget.dart';

class PopularMoviesPage extends StatefulWidget {
  static const route = '/popularmoviespage';
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMoviesPage> {
  Future<dynamic>? popularMoviesData;
  Future<dynamic>? configData;
  final movieService = MovieService();
  Config? config;
  List<PopularMovies>? popularMovies;

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

  getPopularMovies([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await movieService.getPopularMovies(page);
      } else {
        response = await movieService.getPopularMovies();
      }
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
          content: Text('Error grabbing popular movies',
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

  Widget popularMoviesScreen() {
    Iterable<Future<dynamic>> futures = [popularMoviesData!, configData!];
    return FutureBuilder(
      future: Future.wait(futures),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          popularMovies = snapshot.data![0];
          config = snapshot.data![1];
          return movieScroller();
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Flutter MP Demo'),
              CircularProgressIndicator(
                color: Colors.purple,
              ),
            ],
          ),
        );
      },
    );
  }

  int page = 1;

  Widget movieScroller() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: popularMovies!.length + 1,
      itemBuilder: (context, index) {
        if (index == popularMovies!.length) {
          page += 1;
          var newMovies = getPopularMovies(page);
          newMovies.then((movies) {
            if (movies != null) {
              if (mounted) {
                setState(() {
                  popularMovies!.addAll(movies);
                });
              }
            }
          });
        }
        return Column(
          children: [
            PopularMoviesWidget(
              popularMovies![index].id,
              popularMovies![index].title,
              popularMovies![index].posterPath,
              config!.baseUrl,
              config!.logoSizes[4],
            ),
            const Divider(
              color: Colors.black,
              thickness: 1.5,
            )
          ],
        );
      },
    );
  }

  PreferredSizeWidget pageAppBar() {
    return AppBar(
      title: const Text('Popular Movies'),
      centerTitle: false,
    );
  }

  @override
  void initState() {
    super.initState();
    configData = getConfig();
    popularMoviesData = getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageAppBar(),
      body: popularMoviesScreen(),
    );
  }
}
