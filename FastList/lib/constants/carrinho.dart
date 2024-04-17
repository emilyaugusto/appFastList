import 'package:fastlist/constants/produtos.dart';

class Carrinho {
  Set<Produto> itens = {};

  void adicionarItem(Produto produto) {
    itens.add(produto);
  }

  void removerItem(Produto produto) {
    itens.remove(produto);
  }
}
