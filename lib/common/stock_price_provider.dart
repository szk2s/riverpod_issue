import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_issue/common/client.dart';

final stockPriceStreamProvider =
    StreamProvider.autoDispose.family((ref, String symbol) {
  final client = ref.watch(clientProvider);
  final stream = client.subscribeStockPrices();

  ref.onDispose(() {
    client.cancelStream();
  });

  return stream;
});
