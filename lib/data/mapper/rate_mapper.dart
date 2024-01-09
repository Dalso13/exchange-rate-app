import 'package:currency_exchange/data/dto/exchangerate_dto.dart';
import 'package:currency_exchange/data/model/rate_result.dart';

extension RateMapper on ExchangeRateDto {
  RateResult ToMapper() {
    return RateResult(
        lastUpdateTime: DateTime.fromMillisecondsSinceEpoch(
            (timeLastUpdateUnix as int) * 1000),
        nextUpdateTime: DateTime.fromMillisecondsSinceEpoch(
            (timeNextUpdateUnix as int) * 1000),
        baseCode: baseCode as String,
        rates: rates as Map<String, num>);
  }
}
