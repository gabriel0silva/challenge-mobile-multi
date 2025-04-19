import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/states/details_state.dart';
import 'package:flutter/material.dart';

class DetailsViewModel extends ChangeNotifier {
  final FetchMovieDetailsUseCase useCase;

  DetailsViewModel(this.useCase);

  MovieDetailsModel? movieDetails;
  DetailsState state = DetailsState.initial;

  void emitState(DetailsState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> fetchMovieDetails({required int movieId}) async {
    emitState(DetailsState.loading);

    final result = await useCase(movieId);

    if(result != null) {
      movieDetails = result;
      emitState(DetailsState.success);
    } else {
      emitState(DetailsState.failure);
    }
  }
}
