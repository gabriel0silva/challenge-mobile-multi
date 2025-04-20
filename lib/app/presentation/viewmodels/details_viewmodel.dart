import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/domain/entities/trailer_result.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/states/details_state.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsViewModel extends ChangeNotifier {
  final FetchMovieDetailsUseCase useCase;

  DetailsViewModel(this.useCase);

  MovieDetailsModel? movieDetails;
  DetailsState state = DetailsState.initial;
  late YoutubePlayerController youtubeController ;

  bool get isYoutubePlayer => movieDetails!.trailer.type == TrailerType.youtubeKey;
  bool get offstageCertification => movieDetails!.certification.replaceAll('+', '').isEmpty;
  bool get offstageButtonOfficialPage => movieDetails!.homepage.isEmpty;

  void emitState(DetailsState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> fetchMovieDetails({required int movieId, required String movieTitle}) async {
    emitState(DetailsState.loading);

    final result = await useCase(movieId, movieTitle);
  
    if(result != null) {
      movieDetails = result;
      _createYoutubePlayerController(movieDetails!.trailer);
      emitState(DetailsState.success);
    } else {
      emitState(DetailsState.failure);
    }
  }

  void _createYoutubePlayerController(TrailerResult trailer) {
    if(trailer.type == TrailerType.youtubeKey) {
      youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(trailer.value)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          controlsVisibleAtStart: false,
          disableDragSeek: true,
          enableCaption: false,
          isLive: false,
          hideControls: false,
          loop: true,
        ),
      );
    }
  }

  void openTrailerInYoutube() {
    launchUrl(Uri.parse(movieDetails!.trailer.value), mode: LaunchMode.externalApplication);
  }

  void openOficialPage() {
    launchUrl(Uri.parse(movieDetails!.homepage), mode: LaunchMode.externalApplication);
  }

  void clearMemory() {
    if(movieDetails!.trailer.type == TrailerType.youtubeKey) {
      youtubeController.dispose();
    }
    movieDetails = null;
    state = DetailsState.initial;
    debugPrint('Memory Cleared :)');
  }
}
