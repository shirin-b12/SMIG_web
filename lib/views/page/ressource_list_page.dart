import 'package:flutter/material.dart';
import 'package:smig_web/models/ressource.dart';
import 'package:smig_web/services/api_service.dart';
import 'package:smig_web/services/auth_service.dart';
import 'package:smig_web/views/page/ressource_page.dart';
import 'package:smig_web/views/page/login_page.dart';
import 'package:smig_web/widgets/custom_top_app_bar.dart';
import 'package:smig_web/widgets/ressource_card.dart';

import '../screen/transition_page.dart';

class RessourceListPage extends StatelessWidget {
  final ApiService api = ApiService();


  RessourceListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomTopAppBar(),
        body: Column(
          children: <Widget>[
            Row(
              children: [
                SizedBox(width: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                    foregroundColor: Color(0xFF03989E),
                  ),
                  onPressed: () => print("la france tu l'aime ou tu la quitte "),
                  child: const Text('Général ▼', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                ),
                Spacer(),
                Image.asset('assets/gouv/marianne.png', width: 40, height: 40),
                SizedBox(width: 10),
              ],
            ),
            Expanded(
            child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
              child: FutureBuilder(
                future: api.fetchRessources(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Ressource ressource = snapshot.data[index];
                      return LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return InkWell(
                            onTap: () async {
                              // Check if the user is logged in
                              int? userId = await AuthService().getCurrentUser();
                              if (userId != 0) {
                                Navigator.of(context).pushReplacement(CustomMaterialPageRoute(
                                  builder: (context) => RessourcePage(resourceId: ressource.id),
                                ));
                              } else {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              }
                            },
                            child: RessourceCard(ressource: ressource),
                          );
                        },
                      );
                    },
                  );

                  } else {
                    return Text("Aucune donnée disponible");
                  }
                },
              ),
            ),
            )
          ],
        )
    );
  }
}
