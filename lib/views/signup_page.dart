import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_page.dart'; // Assurez-vous d'importer la page de connexion

class SignUpPage extends StatelessWidget {
  final ApiService api = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer un compte')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
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
                final utilisateur = await api.createAccount(nameController.text, surnameController.text, emailController.text, passwordController.text);
                if (utilisateur != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  // Afficher une erreur
                }
              },
              child: Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
