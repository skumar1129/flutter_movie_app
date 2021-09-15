// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/models/movie_details.dart';
import 'package:intl/intl.dart';

class MovieDetailsWidget extends StatelessWidget {
  final int budget;
  final String tagline;
  final String overview;
  final String releaseDate;
  final String backdropPath;
  final List<Genre> genres;
  final double popularity;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final String homepage;
  final String posterPath;
  final String title;
  final List<Languages> languages;
  final String baseUrl;
  final String logoSize;

  const MovieDetailsWidget(
    this.budget,
    this.tagline,
    this.overview,
    this.releaseDate,
    this.backdropPath,
    this.genres,
    this.popularity,
    this.runtime,
    this.voteAverage,
    this.voteCount,
    this.homepage,
    this.posterPath,
    this.title,
    this.languages,
    this.baseUrl,
    this.logoSize,
  );

  Widget voteIcon() {
    return Column(
      children: [
        const Icon(
          Icons.favorite,
          color: Colors.purple,
        ),
        Text(voteAverage.toString()),
      ],
    );
  }

  Widget durationIcon() {
    return Column(
      children: [
        const Icon(
          Icons.access_time,
          color: Colors.purple,
        ),
        Text('${runtime.toString()} min'),
      ],
    );
  }

  Widget dateIcon() {
    return Column(
      children: [
        const Icon(
          Icons.date_range,
          color: Colors.purple,
        ),
        Text(releaseDate),
      ],
    );
  }

  Widget infoCard() {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          voteIcon(),
          durationIcon(),
          dateIcon(),
        ],
      ),
    );
  }

  List<Widget> genreWidgets() {
    List<Widget> genreTexts = [];
    for (var genre in genres) {
      genreTexts.add(Text(genre.name));
    }
    return genreTexts;
  }

  List<Widget> languageWidgets() {
    List<Widget> languageTexts = [];
    for (var language in languages) {
      languageTexts.add(Text(language.language));
    }
    return languageTexts;
  }

  Widget moveDetailsCard() {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    String movieBudget = oCcy.format(budget);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              tagline,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            Text(overview),
            const Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            const Text(
              'Budget',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('\$$movieBudget'),
            const Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            const Text(
              'Genre(s)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ...genreWidgets(),
            const Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            const Text(
              'Language(s)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ...languageWidgets(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: NetworkImage(
              '$baseUrl$logoSize$backdropPath',
            ),
          ),
          infoCard(),
          moveDetailsCard(),
          Image(
            image: NetworkImage(
              '$baseUrl$logoSize$posterPath',
            ),
          )
        ],
      ),
    );
  }
}
