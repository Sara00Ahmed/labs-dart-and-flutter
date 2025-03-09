import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/resoursces/color_manager.dart';
import 'package:my_app/resoursces/db_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: MovieListScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<dynamic> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse(DbManager.movies);


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = data['results'];
          isLoading = false;
        });
      } else {
        print("Failed to load movies: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching movies: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
        backgroundColor: ColorManager.tealColor,
        leading:IconButton(icon: Icon(Icons.arrow_back ,color:ColorManager.whiteColor),
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                 )),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(8), // Add some padding around the grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of cards per row
                crossAxisSpacing: 8, // Horizontal spacing between cards
                mainAxisSpacing: 8, // Vertical spacing between cards
                childAspectRatio: 0.7, // Adjust the aspect ratio of cards
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          titlePadding: const EdgeInsets.all(10.0),
                          title: Text(movie['title'] , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorManager.redColor),textAlign: TextAlign.center,), // عنوان الفيلم(TextAlign.center,),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(DbManager.getImageUrl(movie['poster_path']) ,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              Text(movie['overview']),
                              Text(movie['release_date']),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Watch Now',
                                style: TextStyle(
                                  color: ColorManager.redColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Icon(Icons.close,
                                  color: ColorManager.darkColor),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(DbManager.getImageUrl(movie['poster_path']),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}