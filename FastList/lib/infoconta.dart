import 'package:fastlist/login.dart';
import 'package:flutter/material.dart';

class infoconta extends StatefulWidget {
  const infoconta({super.key});
  _infocontaState createState() => _infocontaState();
}

class _infocontaState extends State<infoconta> {
  TextEditingController nomecontroller = TextEditingController(text: 'NewUser');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0097B2),
        title: Text('Informações'),
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
              child: Container(
                width: 200,
                child: TextField(
                  cursorColor: Color(0xFF0097B2),
                  controller: nomecontroller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Color(0xFF0097B2),
                    ),
                    border: InputBorder.none,
                    hintText: 'Digite seu nome',
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
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
              height: 30,
            ),
            Container(
              height: 50,
              width: 100,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0097B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
