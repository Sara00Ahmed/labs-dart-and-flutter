import 'package:flutter/material.dart';
import 'package:my_app/resoursces/color_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List> fetchMovies(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=YOUR_API_KEY&query=$query");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['results'];  // ✅ إرجاع قائمة الأفلام
      } else {
        print("Failed to load movies: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.blueColor, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Search Movies",
                style: TextStyle(fontSize: 24, color: ColorManager.whiteColor),
              ),
              SizedBox(height: 15), // لإضافة مسافة بين النص ومربع البحث
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20), // إضافة هوامش
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a movie...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: ColorManager.blueColor),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: CustomSearch(fetchMovies),
                        );
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: ColorManager.blueColor),
                    ),
                    filled: true,
                    fillColor: ColorManager.whiteColor,
                    hintStyle: TextStyle(color: ColorManager.greyColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate<void> {
  final Future<List> Function(String) fetchMovies;
  List searchResults = [];
  bool isLoading = false;

  CustomSearch(this.fetchMovies);

  void searchMovies() async {
    if (query.isEmpty) return;

    // ✅ تحديث الواجهة أثناء التحميل
    isLoading = true;
    searchResults = await fetchMovies(query);

    // ✅ تحديث الواجهة بعد جلب البيانات
    isLoading = false;
    // showResults(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
          searchResults.clear();
          showSuggestions(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovies(); // ✅ تشغيل البحث عند عرض النتائج

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          "No movies found!",
          style: TextStyle(color: ColorManager.whiteColor),
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return ListTile(
          leading: movie['poster_path'] != null
              ? Image.network("https://image.tmdb.org/t/p/w92${movie['poster_path']}")
              : Icon(Icons.movie, color: ColorManager.blueColor),
          title: Text(movie['title'] ?? "No Title"),
          subtitle: Text(movie['release_date'] ?? "Unknown Date"),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "Type a movie name to search",
        style: TextStyle(color: ColorManager.whiteColor),
      ),
    );
  }
}
