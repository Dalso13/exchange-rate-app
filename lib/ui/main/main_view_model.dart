import 'package:currency_exchange/data/repository/rate_repository.dart';
import 'package:flutter/material.dart';

import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final RateRepository _rateRepository;

  MainState _state = const MainState();

  MainState get state => _state;

  MainViewModel({
    required RateRepository rateRepository,
  }) : _rateRepository = rateRepository {
    _updateRateResult(state.baseCode);
  }

  Future<void> _updateRateResult(String baseCode) async {
    final result = await _rateRepository.getRateResult(baseCode);
    _state = state.copyWith(rateResult: result);
    notifyListeners();
  }

  void inputBaseMoney(num baseMoney) {
    _state = state.copyWith(
      baseMoney: baseMoney,
      targetMoney: baseMoney *
          state.rateResult!.rates[state.targetCode]!
    );
    notifyListeners();
  }

  void inputBaseCode(String baseCode) async {
    _state = state.copyWith(baseCode: baseCode);

    await _updateRateResult(baseCode);

    _state = state.copyWith(
      targetMoney: state.baseMoney *
          state.rateResult!.rates[state.targetCode]!
    );

    notifyListeners();
  }

  void targetBaseMoney(num baseMoney) {
    _state = state.copyWith(
        targetMoney: baseMoney,
        baseMoney: baseMoney /
            state.rateResult!.rates[state.targetCode]!
    );
    notifyListeners();
  }

  void targetBaseCode(String baseCode) async {
    _state = state.copyWith(baseCode: baseCode);

    await _updateRateResult(baseCode);

    _state = state.copyWith(
        baseMoney: state.baseMoney /
            state.rateResult!.rates[state.targetCode]!
    );

    notifyListeners();

  }
}
