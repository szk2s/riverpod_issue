import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_issue/common/stock_price_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// Simulates API response
final stockSymbolProvider = FutureProvider.autoDispose((ref) async {
  Future<void>.delayed(const Duration(seconds: 1));
  return "SBUX";
});

final stockInfoProvider = FutureProvider.autoDispose((ref) async {
  var symbol = ref.watch(stockSymbolProvider).valueOrNull;
  symbol ??= await ref.watch(stockSymbolProvider.future);
  final price = await ref.watch(stockPriceStreamProvider(symbol!).future);
  return "$symbol @ $price";
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stock Price Demo',
      home: Scaffold(
        body: StockWidget(),
      ),
    );
  }
}

class StockWidget extends ConsumerWidget {
  const StockWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsyncValue = ref.watch(stockInfoProvider);

    return streamAsyncValue.when(
      data: (info) => Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.blue,
        child: Text(info),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('Error: $e'),
    );
  }
}
