import 'package:challenge_mobile_multi/app/core/init/app_initializer.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_viewmodel.dart';

class SplashScreenViewModel {
  final AppInitializer initializer;
  final HomeViewModel homeViewModel;

  SplashScreenViewModel({
    required this.initializer,
    required this.homeViewModel,
  });

  Future<void> init(Function onDone) async {
    await initializer.initializeApp(homeViewModel);
    onDone();
  }
}
