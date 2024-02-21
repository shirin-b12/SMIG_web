import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_page.dart'; // Importez votre page d'accueil ici

class LoginPage extends StatelessWidget {
  final ApiService api = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                final utilisateur = await api.login(emailController.text, passwordController.text);
                if (utilisateur != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  // Afficher une erreur
                }
              },
              child: Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
