import 'package:flutter/material.dart';
import 'package:smig_web/views/page/home_page.dart';
import 'package:smig_web/views/page/ressource_creation_page.dart';
import 'package:smig_web/views/page/stat_page.dart';
import '../page/ressource_list_page.dart';
import '../page/utilisateur_profile.dart';

class BarreDeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade400, width: 0.5),
          bottom: BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _MenuItem(titre: 'Accueil', onTap: () => navigate(context, 'Accueil')),
          _MenuItem(titre: 'Ressource', onTap: () => navigate(context, 'Ressource')),
          _MenuItem(titre: 'Statistiques', onTap: () => navigate(context, 'Statistiques')),
          _MenuItem(titre: 'Création', onTap: () => navigate(context, 'Création')),
        ],
      ),
    );
  }

  void navigate(BuildContext context, String titre) {
    switch (titre) {
      case 'Accueil':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 'Ressource':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RessourceListPage()));
        break;
      case 'Statistiques':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StatPage()));
        break;
      case 'Création':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RessourceCreationPage()));
        break;
      default:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserProfile()));
    }
  }
}

class _MenuItem extends StatelessWidget {
  final String titre;
  final VoidCallback onTap;

  const _MenuItem({Key? key, required this.titre, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => {},  // Optionally handle hover
      onExit: (_) => {},   // Optionally handle hover
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Center(
            child: Text(
              titre,
              style: TextStyle(
                  fontFamily: 'MarianneMedium',
                  fontSize: 16,
                  color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
