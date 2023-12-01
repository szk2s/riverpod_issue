import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_issue/common/stock_price_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

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
    // passing a hard-coded stock symbol
    final streamAsyncValue = ref.watch(stockPriceStreamProvider("SBUX"));

    return streamAsyncValue.when(
      data: (price) => Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.blue,
        child: Text(price.toString()),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('Error: $e'),
    );
  }
}
