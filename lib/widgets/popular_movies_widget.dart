// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/movie_details.dart';

class PopularMoviesWidget extends StatelessWidget {
  final int id;
  final String title;
  final String posterPath;
  final String baseUrl;
  final String logoSize;

  const PopularMoviesWidget(
    this.id,
    this.title,
    this.posterPath,
    this.baseUrl,
    this.logoSize,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, MovieDetailsPage.route,
            arguments: id.toString());
      },
      child: Card(
        child: Row(
          children: [
            Image(
              image: NetworkImage('$baseUrl$logoSize$posterPath'),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
