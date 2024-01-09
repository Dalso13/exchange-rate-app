import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'rate_result.freezed.dart';

part 'rate_result.g.dart';

@freezed
class RateResult with _$RateResult {
  const factory RateResult({
    required DateTime lastUpdateTime,
    required DateTime nextUpdateTime,
    required String baseCode,
    required Map<String,num> rates,
  }) = _RateResult;

  factory RateResult.fromJson(Map<String, Object?> json) => _$RateResultFromJson(json);
}