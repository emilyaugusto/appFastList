import 'package:flutter/material.dart';
import '../constants/produtos.dart';

import 'constants/carrinho.dart';

class TelaCarrinho extends StatefulWidget {
  final Carrinho carrinho;

  TelaCarrinho({
    required this.carrinho,
  });

  @override
  State<TelaCarrinho> createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  void _removeItem(Produto produto) {
    setState(() {
      widget.carrinho.removerItem(produto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carrinho de Compras"),
          backgroundColor: Color(0xFF0097B2),
        ),
        body: widget.carrinho.itens.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seu carrinho está vazio",
                    style: TextStyle(fontSize: 18),
                  ),
                  Image.asset(('assets/images/emojitriste.png')),
                ],
              )
            : ListView.builder(
                itemCount: widget.carrinho.itens.length,
                itemBuilder: (context, index) {
                  final produtosNoCarrinho = widget.carrinho.itens.toList();
                  final produto = produtosNoCarrinho[index];
                  return Dismissible(
                    key: Key(produto.nome),
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
                      _removeItem(produto);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F4F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          produto.nome,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: produto.isChecado
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                            "R\$ ${produto.preco}\nUni. ${produto.unidade}"),
                        leading: Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            produto.imagem,
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0x00f1f4f8),
                          ),
                        ),
                        trailing: Checkbox(
                          value: produto.isChecado,
                          activeColor: Color(0xFF0097B2),
                          onChanged: (isChecked) {
                            setState(() {
                              produto.isChecado = isChecked ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
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
          padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xffbfdae3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Alinhamento do texto à esquerda
                    children: [
                      Text(
                        'Soma dos produtos:',
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
              ),
            ],
          ),
        ));
  }
}
