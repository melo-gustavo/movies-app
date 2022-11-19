import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  late FirebaseFirestore _firestore;

  FirebaseFirestore get firestore => _firestore;

  set firestore(FirebaseFirestore firestore) {
    _firestore = firestore;
  }

  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List?> getAllMovies() async {
    QuerySnapshot querySnapshot;

    List listMovies = [];

    try {
      querySnapshot =
          await firestore.collection('movies').orderBy('name').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var movie in querySnapshot.docs.toList()) {
          Map addMovie = {
            "id": movie.id,
            "name": movie['name'],
            "age_rating": movie['age_rating'],
            "launch_year": movie['launch_year'],
            "gender": movie['gender'],
            "duration": movie['duration'],
            "language": movie['language'],
            "rating": movie['rating']
          };
          listMovies.add(addMovie);
        }
        return listMovies;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> createMovie(String name, String ageRating, String launchYear,
      String gender, String duration, String language, String rating) async {
    try {
      await firestore.collection('movies').add(
        {
          "name": name,
          "age_rating": ageRating,
          "launch_year": launchYear,
          "gender": gender,
          "duration": duration,
          "language": language,
          "rating": rating
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateMovie(
      String id,
      String name,
      String ageRating,
      String launchYear,
      String gender,
      String duration,
      String language,
      String rating) async {
    try {
      await firestore.collection('movies').doc(id).update(
        {
          "name": name,
          "age_rating": ageRating,
          "launch_year": launchYear,
          "gender": gender,
          "duration": duration,
          "language": language,
          "rating": rating
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteMovie(String id) async {
    try {
      await firestore.collection('movies').doc(id).delete();
    } catch (error) {
      print(error);
    }
  }
}
