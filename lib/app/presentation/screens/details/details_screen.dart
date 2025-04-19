import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/presentation/states/details_state.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/details_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      final movieId = ModalRoute.of(context)!.settings.arguments as int;
      viewModel.fetchMovieDetails(movieId: movieId);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Consumer<DetailsViewModel>(
        builder: (context, vm, _) {
          switch (vm.state) {
          case DetailsState.initial:
            return const SizedBox();
          case DetailsState.loading:
            return const CircularProgressIndicator();
          case DetailsState.failure:
            return const Text('Erro');
          case DetailsState.success:
            return Stack(
              children: [
                Container(
                  color: Colors.black,
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
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
                          padding: const EdgeInsets.all(16),
                          child: Text(vm.movieDetails!.title),
                        )
                      ],
                    ),
                  )
                ),
                

              ],
            );
          }
        },
      ),
    );
  }
}
