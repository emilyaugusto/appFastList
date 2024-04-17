import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class criaitem extends StatefulWidget {
  @override
  _criaitemState createState() => _criaitemState();
}

class _criaitemState extends State<criaitem> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  int contador = 0;
  String selectedCategoria = 'Sem categoria';

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
    nomeController = TextEditingController();
    precoController = TextEditingController();
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
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300], // Cor do círculo
                    ),
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
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Text(
                    'Categoria:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: DropdownButton<String>(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    icon: Icon(Icons.arrow_drop_down, color: Color(0xff567176)),
                    value: selectedCategoria,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategoria = newValue!;
                      });
                    },
                    items: <String>[
                      'Grãos',
                      'Hortifruti',
                      'Bebidas',
                      "Doces",
                      "Frios",
                      "Padaria",
                      "Limpeza",
                      "Higiene pessoal",
                      "Sem categoria",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
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
