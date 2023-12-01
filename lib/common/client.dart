import 'dart:async';
import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class StockServiceClient {
  final _controller = StreamController<double>();
  Timer? _timer;

  Stream<double> subscribeStockPrices() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final randomPrice = Random().nextDouble() * 100;
      _controller.add(randomPrice);
    });

    return _controller.stream;
  }

  void cancelStream() {
    print("cancelStream called");
    _timer?.cancel();
    _controller.close();
  }
}

final clientProvider = Provider((ref) => StockServiceClient());
