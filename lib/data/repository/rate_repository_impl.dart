import 'package:currency_exchange/data/api/rate_api.dart';
import 'package:currency_exchange/data/mapper/rate_mapper.dart';
import 'package:currency_exchange/data/model/rate_result.dart';
import 'package:currency_exchange/data/repository/rate_repository.dart';

import '../dto/exchangerate_dto.dart';

class RateRepositoryImpl implements RateRepository {
  final RateApi api;

  RateRepositoryImpl({
    required this.api,
  });

  @override
  Future<RateResult> getRateResult(String baseCode) async {
    final json = await api.getRateApi(baseCode);
    final ExchangeRateDto dto = ExchangeRateDto.fromJson(json);


    return dto.ToMapper();
  }


}