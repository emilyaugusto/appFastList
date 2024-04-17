import 'package:fastlist/NavBar.dart';
import 'package:fastlist/setores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListaProvider(),
      child: crialista(),
    ),
  );
}

class crialista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Color(0xFF0097B2),
          title: Text('Listas'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ListaProvider(), // Aqui está o ListaProvider
          child: ListaRenomeavelWidget(),
        ),
      ),
    );
  }
}

class ListaRenomeavelWidget extends StatefulWidget {
  const ListaRenomeavelWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListaRenomeavelWidgetState createState() => _ListaRenomeavelWidgetState();
}

class _ListaRenomeavelWidgetState extends State<ListaRenomeavelWidget> {
  TextEditingController controller = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listaProvider = Provider.of<ListaProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xffD1D1D1),
          ),
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 60),
              ],
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Criar Lista'),
                    content: Container(
                      height: 110,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: controller,
                              cursorColor: Color(0xFF0097B2),
                              decoration: InputDecoration(
                                labelText: 'Nome da Lista',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0097B2),
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0097B2)),
                                ),
                              ),
                              onSubmitted: (value) {
                                criarLista(listaProvider);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+[\,]?\d*')),
                              ],
                              controller: textController,
                              cursorColor: Color(0xFF0097B2),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0097B2),
                                  ),
                                ),
                                labelText: 'Estimativa de valor',
                                labelStyle: TextStyle(color: Colors.black),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0097B2)),
                                ),
                              ),
                              onSubmitted: (value) {
                                criarLista(listaProvider);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF0097B2),
                        ),
                        onPressed: () {
                          criarLista(listaProvider);
                          Navigator.of(context).pop();
                        },
                        child: Text('Criar'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF0097B2),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listaProvider.listas.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Dismissible(
                    key: Key(listaProvider.listas[index].nome),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      _removeItem(listaProvider, index);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFF1F4F8),
                      ),
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => setores()));
                        },
                        title: Text(
                          listaProvider.listas[index].nome,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                            'R\$ ${listaProvider.listas[index].estimativa}'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController novoNomeController =
                                    TextEditingController(
                                        text: listaProvider.listas[index].nome);
                                TextEditingController novoEstController =
                                    TextEditingController(
                                        text: listaProvider
                                            .listas[index].estimativa);

                                return AlertDialog(
                                  title: Text('Renomear Lista'),
                                  content: Container(
                                    height: 110,
                                    child: Column(children: [
                                      TextField(
                                        controller: novoNomeController,
                                        cursorColor: Color(0xFF0097B2),
                                        decoration: InputDecoration(
                                          labelText: 'Nome da Lista',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFF0097B2),
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF0097B2)),
                                          ),
                                        ),
                                      ),
                                      TextField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+[\,]?\d*')),
                                        ],
                                        controller: novoEstController,
                                        cursorColor: Color(0xFF0097B2),
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFF0097B2),
                                            ),
                                          ),
                                          labelText: 'Nova estimativa',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF0097B2)),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF0097B2),
                                      ),
                                      onPressed: () {
                                        String novoNome =
                                            novoNomeController.text.trim();
                                        String novoEst =
                                            novoEstController.text.trim();
                                        if (novoNome.isNotEmpty) {
                                          listaProvider.renomearLista(
                                              index, novoNome, novoEst);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text('Salvar'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF0097B2),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _removeItem(ListaProvider listaProvider, int index) {
    listaProvider.listas.removeAt(index);
  }

  void criarLista(ListaProvider listaProvider) {
    String nomeLista = controller.text.trim();
    String estimativa =
        textController.text.trim(); // Obter o valor da estimativa
    if (nomeLista.isNotEmpty) {
      listaProvider.adicionarLista(
          nomeLista, estimativa); // Passar a estimativa
      controller.clear();
      textController.clear(); // Limpar o valor da estimativa
    }
  }
}

class ListaProvider extends ChangeNotifier {
  List<ListaItem> listas = [];

  void adicionarLista(String nomeLista, String estimativa) {
    listas.add(ListaItem(nomeLista, estimativa));
    notifyListeners();
  }

  void renomearLista(int index, String novoNome, String novoEst) {
    listas[index].nome = novoNome;
    listas[index].estimativa = novoEst;
    notifyListeners();
  }
}

class ListaItem {
  String nome;
  String estimativa;

  ListaItem(this.nome, this.estimativa);
}
