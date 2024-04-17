import 'dart:math';
import 'package:fastlist/NavBar.dart';
import 'package:fastlist/constants/produtos.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class despesas extends StatefulWidget {
  @override
  _DespesasState createState() => _DespesasState();
}

class _DespesasState extends State<despesas> {
  List<Produto> graos = GraosRepositorio().graos;
  List<Produto> hortifruti = Hortifruti().hortifruti;
  List<Produto> bebidas = Bebidas().bebidas;
  List<PieChartSectionData> pieChartSections = [];
  List<double> sectionPrices = [];
  List<String> sectionNames = [];

  double totalFiveItems = 0;
  int currentMonthIndex = 0;
  List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  void updateMonth(int index) {
    setState(() {
      currentMonthIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _generatePieChartSections();
    DateTime now = DateTime.now();
    currentMonthIndex = now.month - 1;
  }

  void _generatePieChartSections() {
    List<Produto> produto = [];
    produto.addAll(graos);
    produto.addAll(hortifruti);
    produto.addAll(bebidas);

    produto.sort((a, b) => b.preco
        .compareTo(a.preco)); // Ordena todos os produtos por preço decrescente
    int numberOfSections =
        min(produto.length, 5); // Pega no máximo os 5 itens mais caros

    double totalPreco = 0;
    for (int i = 0; i < numberOfSections; i++) {
      totalPreco += produto[i].preco;
    }

    for (int i = 0; i < numberOfSections; i++) {
      double percentual = (produto[i].preco / totalPreco) * 100;
      pieChartSections.add(
        PieChartSectionData(
          color: sectionColors[i],
          value: percentual,
          radius: 50,
          title: ' ',
        ),
      );
      sectionPrices.add(produto[i].preco);
      sectionNames.add(produto[i].nome);

      totalFiveItems = sectionPrices.fold(0, (prev, price) => prev + price);
    }
  }

  void _limitToFive() {
    pieChartSections.sort((a, b) => b.value.compareTo(a.value));
    if (pieChartSections.length > 5) {
      pieChartSections = pieChartSections.sublist(0, 5);
    }
  }

  List<Color> sectionColors = [
    Color(0xFF045F70),
    Color(0xFF029EBA),
    Color(0xFF2ABED9),
    Color(0xFF6BE8FE),
    Color(0xFFD9D9D9),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFF0097B2),
        title: Text('Despesas'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (currentMonthIndex > 0) {
                    updateMonth(currentMonthIndex - 1);
                  }
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(width: 20),
              Text(
                months[currentMonthIndex],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  if (currentMonthIndex < months.length - 1) {
                    updateMonth(currentMonthIndex + 1);
                  }
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Valor total:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                    .format(totalFiveItems),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                sections: pieChartSections,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: List.generate(pieChartSections.length, (index) {
              return Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: sectionColors[index],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${sectionNames[index]}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                            .format(sectionPrices[index]),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      '${pieChartSections[index].value.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
