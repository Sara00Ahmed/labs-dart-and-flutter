
const String databaseName = 'https://api.themoviedb.org/3/movie/now_playing?api_key=837aa67b269303622a476bbe24283a57';
class DbManager {
  DbManager._(); // Constructor خاص
  static final String apikey = '837aa67b269303622a476bbe24283a57';
  static final String movies = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
  static String getImageUrl(String path) => 'https://image.tmdb.org/t/p/w500$path';
}



