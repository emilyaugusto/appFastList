import 'package:flutter/material.dart';
import 'package:fastlist/constants/produtos.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class detalhes extends StatefulWidget {
  final Produto produto;
  detalhes({Key? key, required this.produto}) : super(key: key);

  @override
  _DetalhesState createState() => _DetalhesState(produto.unidade);
}

class _DetalhesState extends State<detalhes> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  int contador;
  String selectedCategoria = 'Sem categoria';

  _DetalhesState(this.contador);

  void incrementarContador() {
    setState(() {
      contador++;
    });
  }

  void decrementarContador() {
    setState(() {
      if (contador > 0) {
        contador--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.produto.nome);
    precoController = TextEditingController(
      text: NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
          .format(widget.produto.preco),
    );
    selectedCategoria = widget.produto.categoria;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0097B2),
        title: Text('Detalhes'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Image.asset(
                    widget.produto.imagem,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Nome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 250,
                  height: 100,
                  child: TextField(
                    controller: nomeController,
                    cursorColor: Color(0xFF0097B2),
                    decoration: InputDecoration(
                      hintText: 'Digite o nome do produto',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0097B2),
                        ),
                      ),
                    ),
                    onChanged: (text) {
                      if (text.isEmpty) {}
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Preço',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 30),
                      child: Text(
                        'Quantidade',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.only(left: 10),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+[\,]?\d*')),
                        ],
                        style: TextStyle(fontSize: 18),
                        controller: precoController,
                        cursorColor: Color(0xFF0097B2),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          if (text.isEmpty) {}
                        },
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$contador',
                        style: TextStyle(fontSize: 18),
                      ),
                      margin: EdgeInsets.only(right: 20),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: incrementarContador,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Color(0xFF004D5A),
                              size: 40, // Tamanho do ícone
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: decrementarContador,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF004D5A),
                              size: 40, // Tamanho do ícone
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Spacer(),
            Center(
              child: Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0097B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
