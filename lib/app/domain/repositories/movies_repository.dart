
class MoviesRepository {
  MoviesRepository._();

  static final MoviesRepository _instance = MoviesRepository._();
  factory MoviesRepository() => MoviesRepository._instance;


  Future<dynamic> fetchTopRatedMovies() async {

  }

  Future<dynamic> fecthNowCineMovies() async {

  }

  Future<dynamic> fecthShortlyMovies() async {

  }

  // Future<List<Movie>> getTopRatedMovies();
  // Future<List<Movie>> fecthNowCineMovies();in theaters
}