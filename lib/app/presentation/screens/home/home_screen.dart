import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:challenge_mobile_multi/app/presentation/states/home_state.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_scaffold.dart';
import 'package:challenge_mobile_multi/app/routes/app_routes.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Consumer<HomeViewModel>(builder: (context, vm, _) {
      switch (vm.state) {
        case HomeState.initial:
          return const SizedBox();
        case HomeState.loading:
          return const CircularProgressIndicator();
        case HomeState.failure:
          return const Text('Erro');
        case HomeState.success:
          return _successWidget(l10n, vm, context);
      }
    });
  }
}

DefaultScaffold _successWidget(AppLocalizations l10n, HomeViewModel vm, BuildContext context) {
  return DefaultScaffold(
    appBar: AppBar(
      toolbarHeight: 70,
      titleSpacing: 16,
      backgroundColor: Colors.transparent,
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              AppAssets.svgIconProfile,
            ),
          ),
        ),
      ],
      title: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              l10n.translate('language'),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontFamily: AppFonts.montserratMedium,
              ),
            ),
            Row(
              spacing: 4,
              children: [
                SvgPicture.asset(
                  AppAssets.svgIconLocation,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                DropdownButton<String>(
                  value: vm.selectedValue,
                  underline: const SizedBox(),
                  isDense: true,
                  dropdownColor: Colors.transparent,
                  style: const TextStyle(color: AppColors.white),
                  iconEnabledColor: AppColors.white,
                  padding: EdgeInsets.zero,
                  onChanged: (String? newValue) async {
                    context.read<LocaleViewModel>().setLocale(newValue == l10n.translate('portuguese') ? const Locale('pt') : const Locale('en'));
                    await vm.changeLanguage(newValue == l10n.translate('english') ? 'English' : 'Português');
                  },
                  items: [
                    l10n.translate('portuguese'),
                    l10n.translate('english')
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontFamily: AppFonts.montserratMedium,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    body: SafeArea(
      child: Column(
        spacing: 12,
        children: [
          _carouselMovies(vm)

        ],
      ),
    )
  );
}

Column _carouselMovies(HomeViewModel vm) {
  return Column(
    children: [
      SizedBox(
        height: Data.height * 0.38,
        child: CarouselSlider(
          options: CarouselOptions(
            height: Data.height * 0.35,
            aspectRatio: 16 / 9,
            viewportFraction: 0.50,
            enlargeCenterPage: true,
            autoPlay: true,
            initialPage: vm.topRatedMoviesController.initialPage,
            onPageChanged: (index, reason) {
              vm.updateCarouselIndex(index);
            },
          ),
          items: vm.topRatedMovies.map((movie) {
            return Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.details, arguments: movie.id);
                  },
                  child: CachedNetworkImage(
                    imageUrl: movie.posterPath,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.white),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.pink,
                              blurRadius: 15,
                              offset: Offset(0, 0),
                            )
                          ],
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
                );
              },
            );
          }).toList(),
        ),
      ),
      AnimatedSmoothIndicator(
        activeIndex: vm.currentCarouselIndex,
        count: vm.topRatedMovies.length,
        effect: const ScrollingDotsEffect(
          activeStrokeWidth: 2.5,
          activeDotScale: 1.6,
          maxVisibleDots: 5,
          radius: 8,
          spacing: 6,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: AppColors.pink,
          dotColor: AppColors.white,
        ),
      ),
    ],
  );
}