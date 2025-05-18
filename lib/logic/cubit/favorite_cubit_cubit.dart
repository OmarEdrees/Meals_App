import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_cubit_state.dart';

class FavoriteCubit extends Cubit<Set<String>> {
  FavoriteCubit() : super(<String>{});

  void toggleFavorite(String name) {
    if (state.contains(name)) {
      emit(Set.from(state)..remove(name));
    } else {
      emit(Set.from(state)..add(name));
    }
  }

  bool isFavorite(String name) {
    return state.contains(name);
  }

  Future<void> loadFavoritesFromFirebase() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Favorite').get();
      final favoriteNames =
          snapshot.docs.map((doc) => doc['name'].toString()).toSet();
      emit(Set.from(favoriteNames));
    } catch (e) {
      print('Error loading favorites from Firebase: $e');
    }
  }
}

class UserCubit extends Cubit<String> {
  UserCubit() : super('');

  void updateUsername(String newName) {
    emit(newName);
  }
}
