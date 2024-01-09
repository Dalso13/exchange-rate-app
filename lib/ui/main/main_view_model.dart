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

  void inputBaseMoney(num money) {
    _state = state.copyWith(
      baseMoney: money,
      targetMoney: money *
          state.rateResult!.rates[state.targetCode]!
    );
    notifyListeners();
  }

  Future<void> inputBaseCode(String baseCode, String targetCode) async {
    _state = state.copyWith(baseCode: baseCode, targetCode: targetCode);

    await _updateRateResult(baseCode);

    _state = state.copyWith(
      targetMoney: state.baseMoney *
          state.rateResult!.rates[state.targetCode]!
    );

    inputBaseMoney(state.baseMoney);
    notifyListeners();
  }

  void targetBaseMoney(num money) {
    _state = state.copyWith(
        targetMoney: money,
        baseMoney: money /
            state.rateResult!.rates[state.targetCode]!
    );
    notifyListeners();
  }

}
