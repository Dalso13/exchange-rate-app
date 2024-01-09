import 'package:currency_exchange/data/repository/rate_repository.dart';
import 'package:currency_exchange/data/repository/rate_repository_impl.dart';
import 'package:currency_exchange/ui/main/main_view_model.dart';
import 'package:get_it/get_it.dart';

import '../data/api/rate_api.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<RateApi>(RateApi());
  getIt.registerSingleton<RateRepository>(RateRepositoryImpl(api: getIt<RateApi>()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel(rateRepository: getIt<RateRepository>()));
}