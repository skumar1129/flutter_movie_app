import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/popular_movies.dart';
import 'package:flutter_demo/pages/movie_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: PopularMoviesPage.route,
      routes: {
        PopularMoviesPage.route: (context) => PopularMoviesPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MovieDetailsPage.route) {
          return MaterialPageRoute(builder: (context) {
            return MovieDetailsPage(settings.arguments as String);
          });
        }
      },
    );
  }
}
