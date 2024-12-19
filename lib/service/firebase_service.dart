/* -------------------------------------------------------------------------- */
/*                         Import Required Packages                            */
/* -------------------------------------------------------------------------- */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/model.dart';

/* -------------------------------------------------------------------------- */
/*                         Firebase Service Class                             */
/* -------------------------------------------------------------------------- */
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* -------------------------------------------------------------------------- */
  /*                         Add Movie to Watchlist                            */
  /* -------------------------------------------------------------------------- */
  Future<void> addToWatchlist(Movie movie) async {
    try {
      await _firestore.collection('watchlist').doc(movie.id.toString()).set(
            movie.toMap(),
          );
    } catch (e) {
      rethrow;
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                         Remove Movie from Watchlist                       */
  /* -------------------------------------------------------------------------- */
  Future<void> removeFromWatchlist(String movieId) async {
    try {
      await _firestore.collection('watchlist').doc(movieId).delete();
    } catch (e) {
      rethrow;
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                         Check Watchlist Status                            */
  /* -------------------------------------------------------------------------- */
  Future<bool> isInWatchlist(String movieId) async {
    try {
      final doc = await _firestore.collection('watchlist').doc(movieId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                         Get All Watchlist Movies                          */
  /* -------------------------------------------------------------------------- */
  Stream<List<Movie>> getWatchlistMovies() {
    return _firestore.collection('watchlist').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList();
    });
  }
}
