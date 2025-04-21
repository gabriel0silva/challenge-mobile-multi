import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/domain/entities/trailer_result.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/details_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/states/details_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MockFetchMovieDetailsUseCase extends Mock implements FetchMovieDetailsUseCase {}
class MockYoutubePlayerController extends Mock implements YoutubePlayerController {}

void main() {
  late DetailsViewModel detailsViewModel;
  late MockFetchMovieDetailsUseCase mockFetchMovieDetailsUseCase;
  late MockYoutubePlayerController mockYoutubePlayerController;

  setUp(() {
    mockFetchMovieDetailsUseCase = MockFetchMovieDetailsUseCase();
    detailsViewModel = DetailsViewModel(mockFetchMovieDetailsUseCase);
    mockYoutubePlayerController = MockYoutubePlayerController();
  });

  group('fetchMovieDetails', () {
    final movieDetails = MovieDetailsModel(
      backdropPath: '', 
      budget: 0, 
      genres: [], 
      originCountries: [], 
      originalTitle: '', 
      overview: '', 
      posterPath: '', 
      releaseDate: '', 
      title: '', 
      video: false, 
      voteAverage: 0.0, 
      voteCount: 0, 
      trailer: const TrailerResult(type: TrailerType.youtubeKey, value: '7pVaGNOp5Vc'),
      certification: '',
      homepage: '',
    );

    test('should emit loading and then success when data is fetched successfully', () async {
      when(() => mockFetchMovieDetailsUseCase(155, 'Batman: Cavalheiro das trevas')).thenAnswer((_) async => movieDetails);
      await detailsViewModel.fetchMovieDetails(movieId: 155, movieTitle: 'Batman: Cavalheiro das trevas');

      expect(detailsViewModel.state, DetailsState.success);
      expect(detailsViewModel.movieDetails, isNotNull);
      expect(detailsViewModel.isYoutubePlayer, true);
      verify(() => mockFetchMovieDetailsUseCase(155, 'Batman: Cavalheiro das trevas')).called(1);
    });

    test('should emit loading and then failure when no data is fetched', () async {
      when(() => mockFetchMovieDetailsUseCase(155, 'Batman: Cavalheiro das trevas')).thenAnswer((_) async => null);

      await detailsViewModel.fetchMovieDetails(movieId: 155, movieTitle: 'Batman: Cavalheiro das trevas');

      expect(detailsViewModel.state, DetailsState.failure);
      expect(detailsViewModel.movieDetails, isNull);
      verify(() => mockFetchMovieDetailsUseCase(155, 'Batman: Cavalheiro das trevas')).called(1);
    });

    test('should emit state correctly', () {
      detailsViewModel.addListener(() {
        expect(detailsViewModel.state, DetailsState.loading);
      });

      detailsViewModel.emitState(DetailsState.loading);
    });

    test('should clear memory and reset values', () async {
      when(() => mockFetchMovieDetailsUseCase(155, any())).thenAnswer((_) async => movieDetails);

      await detailsViewModel.fetchMovieDetails(
        movieId: 155,
        movieTitle: 'Batman: Cavalheiro das trevas',
      );

      detailsViewModel.youtubeController = mockYoutubePlayerController;

      detailsViewModel.clearMemory();

      expect(detailsViewModel.movieDetails, isNull);
      expect(detailsViewModel.state, DetailsState.initial);
      verify(() => mockYoutubePlayerController.dispose()).called(1);
    });
  });
}
