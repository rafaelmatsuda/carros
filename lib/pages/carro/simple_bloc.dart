import 'dart:async';

import 'carro.dart';

class SimpleBloc<T> {
  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void add(Object object) {
    _controller.add(object);
  }

  void addError(T error) {
    if (! _controller.isClosed) {
      _controller.addError(T);
    }
  }
}
