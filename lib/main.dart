import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
 



void main() async {
runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
 Color backgroundColor = const Color(0xFFBBDEFB);
  Color appBarColor = const Color(0xFF1565C0);
  final nameController = TextEditingController();
  final dataController = TextEditingController();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold( 
      body:Card(
      margin: EdgeInsets.zero,
      elevation: 10,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF1565C0),
          title: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Nome",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: dataController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Data de nascimento",
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => login(context),
                  child: Text("Entrar"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
      ),
    );
  }
    void changePage() async {
    final user = await showDialog<dynamic>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(width: 400, height: 300, child: HomePage()),
      ),
    );
    {
      setState(() {
        user.add(user);
      });
    }
  }
  


  void login(BuildContext innerContext) {
    String nome = nameController.text;
    String dataNascimento = dataController.text;
    User user = User(nome, dataNascimento);
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomePage(userName: user.nome),
      ),
    );
  }
}


class User {
  String nome;
  String dataNascimento;

  User(this.nome, this.dataNascimento);
}
