import 'package:currency_exchange/ui/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _baseCurrency = 'KRW';
  String _targetCurrency = 'USD';

  final TextEditingController baseController = TextEditingController();
  final TextEditingController targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('환율 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 기준 통화 금액 입력 필드
            TextField(
              controller: baseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '기준 통화 금액',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  viewModel.inputBaseMoney(double.parse(value));
                  targetController.text = '${context.read<MainViewModel>().state.targetMoney}';
                }
              },
            ),
            // 기준 통화 드롭다운 목록
            DropdownButton<String>(
              value: _baseCurrency,
              onChanged: (value) {
                if (_targetCurrency == value) {
                  _targetCurrency = _baseCurrency;
                }
                _baseCurrency = value!;
                if (baseController.text.isNotEmpty &&
                    targetController.text.isNotEmpty) {
                    viewModel.inputBaseCode(_baseCurrency,_targetCurrency).then((value) {
                      targetController.text = '${context.read<MainViewModel>().state.targetMoney}';
                    });
                }
              },
              items: [
                getMenu('KRW'),
                getMenu('USD'),
                getMenu('EUR'),
                getMenu('JPY'),
              ],
            ),
            // 대상 통화 금액 입력 필드
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '대상 통화 금액',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  viewModel.targetBaseMoney(
                      double.parse(value));
                  baseController.text = '${context.read<MainViewModel>().state.baseMoney}';
                }
              },
            ),
            // 대상 통화 드롭다운 목록
            DropdownButton<String>(
              value: _targetCurrency,
              onChanged: (value) {
                if (_baseCurrency == value) {
                  _baseCurrency = _targetCurrency;
                }
                _targetCurrency = value!;

                if (baseController.text.isNotEmpty &&
                    targetController.text.isNotEmpty) {
                  viewModel.inputBaseCode(_baseCurrency,_targetCurrency).then((value) {
                    targetController.text = '${context.read<MainViewModel>().state.targetMoney}';
                  });
                }
              },
              items: [
                getMenu('KRW'),
                getMenu('USD'),
                getMenu('EUR'),
                getMenu('JPY'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  DropdownMenuItem<String> getMenu(String value) {
    return DropdownMenuItem(
      value: '$value',
      child: Text('$value'),
    );
  }
}