import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:challenge_mobile_multi/app/core/utils/functions.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/presentation/states/details_state.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/details_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_button.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_failure.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_loading.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_scaffold.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final viewModel = getIt<DetailsViewModel>();
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final movieId = arguments['movieId'];
      final movieTitle = arguments['movieTitle'];
      viewModel.fetchMovieDetails(movieId: movieId, movieTitle: movieTitle);
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.clearMemory();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultScaffold(
      body: Consumer<DetailsViewModel>(
        builder: (context, vm, _) {
          final arguments = ModalRoute.of(context)!.settings.arguments as Map;
          final movieId = arguments['movieId'];
          final movieTitle = arguments['movieTitle'];
          
          switch (vm.state) {
          case DetailsState.initial:
            return const SizedBox();
          case DetailsState.loading:
            return DefaultLoading(message: l10n.translate('loading_details'));
          case DetailsState.failure:
            return DefaultFailure(onRetry: () => vm.fetchMovieDetails(movieId: movieId, movieTitle: movieTitle));
          case DetailsState.success:
            return _successWidget(vm, l10n, context);
          }
        },
      ),
    );
  }

  Stack _successWidget(DetailsViewModel vm, AppLocalizations l10n, BuildContext context) {
    return Stack(
      children: [
        _movieVideo(vm),
        _movieDetails(vm, l10n),
        _backButton()
      ],
    );
  }

  Positioned _movieDetails(DetailsViewModel vm, AppLocalizations l10n) {
    return Positioned(
      bottom: 0,
      child: Stack(
        children: [
          Positioned(
            top: 9,
            child: Opacity(
              opacity: 0.8,
              child: Container(
                height: 100,
                width: Data.width,
                decoration:  BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(17.3),
                  border: const Border(
                    top: BorderSide(
                      color: AppColors.white,
                    )
                  )
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                      child: Opacity(
                        opacity: 0.3,
                        child: Container(
                          width: Data.width,
                          height: Data.height * 0.55,
                          decoration: const BoxDecoration(
                            gradient: AppColors.gradientPurple,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16), 
                              topRight: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: Data.height * 0.55,
                      padding: const EdgeInsets.all(16),
                      width: Data.width,
                      child:  SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Offstage(
                                  offstage: vm.offstageCertification,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Functions.colorAccordingToTheCertification(vm.movieDetails!.certification),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      vm.movieDetails!.certification,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: AppFonts.montserratBold,
                                        color: AppColors.white, 
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  vm.movieDetails!.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: AppFonts.montserratBold,
                                    color: AppColors.white, 
                                  ),
                                ),
                                Wrap(
                                  spacing: 8,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    _detailInformationOne(vm.movieDetails!.originalTitle),
                                    _detailInformationOne(vm.movieDetails!.yearReleaseDate!),
                                  ],
                                ),
                                Row(
                                  spacing: 8,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.svgIconStar,
                                      height: 24,
                                      width: 24,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          height: 0.9,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: vm.movieDetails!.voteAverage.toString(),
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontFamily: AppFonts.montserratBold,
                                              color: AppColors.gray4, 
                                            ),
                                          ),
                                          TextSpan(
                                            text: '  ${vm.movieDetails!.voteCount} ${l10n.translate('votes')}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: AppFonts.montserratMedium,
                                              color: AppColors.gray4, 
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                    
                                  ],
                                ),
                                Text(
                                  vm.movieDetails!.formattedGenres!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.montserratItalicMedium,
                                    color: AppColors.gray, 
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.translate('overview'),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: AppFonts.montserratBold,
                                    color: AppColors.white, 
                                  ),
                                ),
                                Text(
                                  vm.movieDetails!.overview,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.montserratMedium,
                                    color: AppColors.gray, 
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: Data.width * 0.03, 
                              runSpacing: 12,
                              children: [
                                _detailInformationsTwo(
                                  l10n.translate('release_date'),
                                  vm.movieDetails!.releaseDate,
                                ),
                                _detailInformationsTwo(
                                  l10n.translate('origin_country'),
                                  vm.movieDetails!.originCountry!,
                                ),
                                _detailInformationsTwo(
                                  l10n.translate('budget'),
                                  vm.movieDetails!.budgetformatted!,
                                ),
                              ],
                            ),
                            DefaultButton(
                              offstage: vm.offstageButtonOfficialPage,
                              title: l10n.translate('official_page'), 
                              onTap: vm.openOficialPage,
                            ),
                            const SizedBox(height: 60,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _movieVideo(DetailsViewModel vm,) {
    if(vm.isYoutubePlayer) {
      return SizedBox(
        width: Data.width,
        height: Data.height * 0.45,
        child: YoutubePlayer(
          controller: vm.youtubeController,
          bufferIndicator: const SizedBox(),
          thumbnail: Stack(
            children: [
              Container(
                color: AppColors.black,
                width: Data.width,
                height: Data.height * 0.47,
                child: CachedNetworkImage(
                  imageUrl: vm.movieDetails!.backdropPath,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                color: AppColors.blackOppacity,
              ),
              Center(
                child: ClipOval(
                  child: Container(
                    width: 70,
                    height: 70,
                    color: AppColors.blackOppacity,
                  ),
                ),
              ),
            ],
          ),
          bottomActions: const [],
          onReady: () {
            debugPrint('Player is ready.');
          },
        ),
      );
    }

    return SizedBox(
      width: Data.width,
      height: Data.height * 0.47,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: vm.movieDetails!.backdropPath,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          InkWell(
            onTap: () {
              vm.openTrailerInYoutube();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: AppColors.blackOppacity,
                ),
                ClipOval(
                  child: Container(
                    width: 70,
                    height: 70,
                    color: AppColors.blackOppacity,
                  ),
                ),
                const Icon(
                  Icons.play_arrow_rounded,
                  size: 68,
                  color: AppColors.white,
                )
              ],
            ),
          ),
        ],
      ),
  );
  }

  SafeArea _backButton() {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 12, left: 16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blackOppacity,
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
  
  Widget _detailInformationOne(String title,) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.montserratMedium,
            color: AppColors.gray, 
          ),
        ),
        Container(
          height: 4,
          width: 4,
          decoration: const BoxDecoration(
            color: AppColors.gray,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _detailInformationsTwo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontFamily: AppFonts.montserratMedium,
            color: AppColors.gray1,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.montserratBold,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}