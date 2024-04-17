
import 'package:flutter/foundation.dart';

class ListaProvider extends ChangeNotifier {
  List<String> listas = [];

  void adicionarLista(String nomeLista) {
    listas.add(nomeLista);
    notifyListeners();
  }

  void renomearLista(int index, String novoNome) {
    listas[index] = novoNome;
    notifyListeners();
  }
}
