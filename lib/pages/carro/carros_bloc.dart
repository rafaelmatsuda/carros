import 'dart:async';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  loadCarros(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);
    } catch (e) {
      print(e);
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
