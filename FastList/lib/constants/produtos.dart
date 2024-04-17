class Produto {
  String nome;
  double preco;
  String imagem;
  int unidade;
  bool isChecado;
  String categoria;

  Produto(
      {required this.nome,
      required this.preco,
      required this.imagem,
      required this.unidade,
      required this.isChecado,
      required this.categoria});
}

class GraosRepositorio {
  List<Produto> graos = [
    Produto(
      nome: 'Arroz',
      preco: 10.00,
      imagem: 'assets/images/arroz.png',
      unidade: 2,
      isChecado: false,
      categoria: 'Grãos',
    ),
    Produto(
      nome: 'Feijão',
      preco: 7.50,
      imagem: 'assets/images/feijao.png',
      unidade: 4,
      isChecado: false,
      categoria: 'Grãos',
    ),
    Produto(
      nome: 'Aveia',
      preco: 5.00,
      imagem: 'assets/images/aveia.png',
      unidade: 2,
      isChecado: false,
      categoria: 'Grãos',
    ),
    Produto(
      nome: 'Quinoa',
      preco: 12.00,
      imagem: 'assets/images/quinoa.png',
      unidade: 1,
      isChecado: false,
      categoria: 'Grãos',
    ),
    Produto(
      nome: 'Lentilha',
      preco: 20.00,
      imagem: 'assets/images/lentilha.png',
      unidade: 1,
      isChecado: false,
      categoria: 'Grãos',
    ),
    Produto(
      nome: 'Grão-de-bico',
      preco: 25.00,
      imagem: 'assets/images/graodebico.png',
      unidade: 2,
      isChecado: false,
      categoria: 'Grãos',
    ),
    Produto(
      nome: 'Pipoca',
      preco: 15.00,
      imagem: 'assets/images/pipoca.png',
      unidade: 6,
      isChecado: false,
      categoria: 'Grãos',
    ),
  ];
}

class Hortifruti {
  List<Produto> hortifruti = [
    Produto(
      nome: 'Maçã',
      preco: 2.00,
      imagem: 'assets/images/maca.png',
      unidade: 1,
      isChecado: false,
      categoria: 'Hortifruti', // Defina a categoria corretamente
    ),
  ];
}

class Bebidas {
  List<Produto> bebidas = [
    Produto(
      nome: 'Água',
      preco: 4.00,
      imagem: 'assets/images/agua.png',
      unidade: 6,
      isChecado: false,
      categoria: 'Bebidas', // Defina a categoria corretamente
    ),
  ];
}
