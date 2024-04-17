import 'package:fastlist/configuracoes.dart';
import 'package:fastlist/crialista.dart';
import 'package:fastlist/despesas.dart';
import 'package:fastlist/infoconta.dart';
import 'package:fastlist/setores.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          Container(
            height: 100, // Altura do cabeçalho
            child: DrawerHeader(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => infoconta()));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/user.png',
                        )),
                    SizedBox(width: 10), // Espaçamento entre a imagem e o texto
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'NewUser',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Newuser@gmail.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Setores'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => setores()));
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Listas'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => crialista()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Despesas'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => despesas()));
            },
          ),
          Container(
            width: 90,
            height: 90,
          ),
          Divider(
            color: Colors.grey,
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => configuracoes()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Sobre'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
