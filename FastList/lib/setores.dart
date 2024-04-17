import 'package:fastlist/NavBar.dart';
import 'package:fastlist/constants/carrinho.dart';
import 'package:fastlist/constants/produtos.dart';
import 'package:fastlist/criaitem.dart';
import 'package:fastlist/detalhes.dart';
import 'package:fastlist/telacarrinho.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class setores extends StatelessWidget {
  const setores({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHome(),
    );
  }
}

class MainHome extends StatefulWidget {
  const MainHome({
    Key? key,
  }) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<Produto> produtos = []; // Lista de produtos filtrados

  TextEditingController searchController = TextEditingController();
  TextEditingController priceController = TextEditingController(text: '204,79');

  GraosRepositorio graosRepositorio = GraosRepositorio();
  Hortifruti hortifruti = Hortifruti();
  Bebidas bebidas = Bebidas();
  Carrinho carrinho = Carrinho();

  bool isTextFieldPressed = false;

  List<String> categorias = [
    "Todos",
    "Grãos",
    "Hortifruti",
    "Bebidas",
    "Doces",
    "Frios",
    "Padaria",
    "Limpeza",
    "Higiene pessoal",
    "Sem categoria",
  ];
  void _filtrarPorCategoria(String categoria) {
    setState(() {
      switch (categoria.toLowerCase()) {
        case "todos":
          produtos.clear();
          produtos.addAll(GraosRepositorio().graos);
          produtos.addAll(Hortifruti().hortifruti);
          produtos.addAll(Bebidas().bebidas);
          break;
        case "grãos":
          produtos.clear();
          produtos = GraosRepositorio().graos;
          break;
        case "hortifruti":
          produtos.clear();
          produtos = Hortifruti().hortifruti;
          break;
        case "bebidas":
          produtos.clear();
          produtos = Bebidas().bebidas;
          break;
      }
      current = categorias.indexOf(categoria); // Atualize a categoria atual
    });
  }

  void _doSomething() {
    if (isTextFieldPressed) {
      // O TextField está pressionado
    } else {
      // O TextField não está pressionado
    }
  }

  mostrarDetalhes(Produto produto) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => detalhes(produto: produto),
        ));
  }

  @override
  void initState() {
    super.initState();
    produtos.clear();
    produtos.addAll(GraosRepositorio().graos);
    produtos.addAll(Hortifruti().hortifruti);
    produtos.addAll(Bebidas().bebidas);
  }

  void filterSearchResults(String query) {
    List<Produto> searchResults = [];

    if (query.isNotEmpty) {
      query = query.toLowerCase();
      searchResults.addAll(GraosRepositorio().graos);
      searchResults.addAll(Hortifruti().hortifruti);
      searchResults.addAll(Bebidas().bebidas);

      // Filtra os produtos que correspondem à pesquisa
      searchResults = searchResults.where((produto) {
        return produto.nome.toLowerCase().contains(query);
      }).toList();
    } else {
      // Quando a consulta está vazia, mostre todos os produtos da categoria atual
      switch (current) {
        case 0: // "todos"
          searchResults.addAll(GraosRepositorio().graos);
          searchResults.addAll(Hortifruti().hortifruti);
          searchResults.addAll(Bebidas().bebidas);
          break;
        case 1: // "grãos"
          searchResults.addAll(GraosRepositorio().graos);
          break;
        case 2: // "hortifruti"
          searchResults.addAll(Hortifruti().hortifruti);
          break;
        case 3: // "bebidas"
          searchResults.addAll(Bebidas().bebidas);
          break;
        default:
          break;
      }
    }

    setState(() {
      produtos = searchResults;
    });
  }

  int current = 0;

  double calcularSoma(List<Produto> listaProdutos) {
    double soma = 0.0;
    for (var produto in listaProdutos) {
      soma += produto.preco;
    }
    return soma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xff000000),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(38, 0, 38, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Mude para MainAxisSize.min
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      'Saldo disponível',
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                    child: TextField(
                      onSubmitted: (value) {},
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+[\,]?\d*')),
                      ],
                      controller: priceController,
                      cursorColor: Color(0xFF0097B2),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Digite seu saldo',
                        prefixText: 'R\$ ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isTextFieldPressed = true;
                        });
                      },
                      onTapOutside: (event) {
                        setState(() {
                          isTextFieldPressed = false;
                        });
                      },
                      controller: searchController,
                      onChanged: filterSearchResults,
                      cursorColor: Color(0xFF0097B2),
                      decoration: InputDecoration(
                        hintText: 'Digite sua pesquisa...',
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xffa4a4a4)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF0097B2),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// CUSTOM TABBAR
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categorias.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _filtrarPorCategoria(categorias[index]);
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 80,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? const Color(0xFF0097B2)
                                  : const Color(0x00ffffff),
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: const Color(0x000099c8), width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                categorias[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: current == index
                                        ? const Color(0xffffffff)
                                        : const Color(0xff444444)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => criaitem()));
              },
              child: Visibility(
                visible: isTextFieldPressed,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 70,
                  child: Text(
                    'Criar produtos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffA0A0A0),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F4F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          mostrarDetalhes(produtos[index]);
                        },
                        title: Text(
                          "${produtos[index].nome}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                              .format(produtos[index].preco),
                        ),
                        leading: Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            produtos[index].imagem,
                            fit: BoxFit.cover,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0x00f1f4f8),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: () {
                            carrinho.adicionarItem(produtos[index]);
                            SnackBar snackBar = SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                  'Foi adicionado ${produtos[index].nome} ao carrinho',
                                  style: TextStyle(color: Colors.black)),
                              duration: Duration(milliseconds: 1000),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 90,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Cor da sombra
              spreadRadius: 5, // Raio de propagação da sombra
              blurRadius: 7, // Raio de desfoque da sombra
              offset: const Offset(
                  0, 3), // Deslocamento da sombra (horizontal, vertical)
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(35, 20, 20, 20),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 232,
              decoration: BoxDecoration(
                color: const Color(0xffbfdae3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinhamento do texto à esquerda
                children: [
                  Text(
                    'Carrinho:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'R\$ 100,00',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TelaCarrinho(
                            carrinho: carrinho,
                          )));
                },
                child: const Icon(Icons.checklist),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF0097B2)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
