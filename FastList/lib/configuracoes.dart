import 'package:fastlist/infoconta.dart';
import 'package:flutter/material.dart';

class configuracoes extends StatefulWidget {
  const configuracoes({super.key});
  _configuracoesState createState() => _configuracoesState();
}

class _configuracoesState extends State<configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0097B2),
        title: Text('Configurações'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                      'assets/images/user.png',
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'NewUser',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                'Newuser@gmail.com',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 44,
              thickness: 1,
              indent: 24,
              endIndent: 24,
              color: Color(0xFFE0E3E7),
            ),
            // Generated code for this Row Widget...
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 2,
                ),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => infoconta()));
                },
                title: Text('Informações da conta'),
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xFF14181B),
                  size: 24,
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 2,
                ),
              ),
              child: ListTile(
                onTap: () {},
                title: Text('Notificações'),
                leading: Icon(
                  Icons.notifications,
                  color: Color(0xFF14181B),
                  size: 24,
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 2,
                ),
              ),
              child: ListTile(
                onTap: () {},
                title: Text('Termos e Privacidade'),
                leading: Icon(
                  Icons.description,
                  color: Color(0xFF14181B),
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
