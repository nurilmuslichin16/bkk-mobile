import 'package:bkkmobile/models/loker_model.dart';
import 'package:bkkmobile/services/loker_service.dart';
import 'package:flutter/material.dart';

class LokerProdvider with ChangeNotifier {
  List<LokerModel> _lokers = [];
  List<LokerModel> get lokers => _lokers;

  set lokers(List<LokerModel> lokers) {
    _lokers = lokers;
    notifyListeners();
  }

  Future<void> getLokers() async {
    try {
      List<LokerModel> lokers = await LokerService().getLokers();
      _lokers = lokers;
    } catch (e) {
      print(e);
    }
  }
}
