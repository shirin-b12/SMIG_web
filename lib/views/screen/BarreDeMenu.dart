import 'package:flutter/material.dart';

import '../page/ressource_list_page.dart';
import '../page/utilisateur_profile.dart';

class BarreDeMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenidth,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade400, width: 0.5),
          bottom: BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
        color: Colors.white,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _MenuItem(titre: 'Accueil'),
          _MenuItem(titre: 'À Propos'),
          _MenuItem(titre: 'Services'),
          _MenuItem(titre: 'Contact'),
        ],
      ),
    );
  }

}

class _MenuItem extends StatefulWidget {
  final String titre;

  const _MenuItem({Key? key, required this.titre}) : super(key: key);

  @override
  State<_MenuItem> createState() => _MenuItemState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserProfile()));

          print('Clic sur $titre');
        },
        child: Text(
          titre,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }


}
class _MenuItemState extends State<_MenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => isHovered = true),
      onExit: (event) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RessourceListPage()));

          print('Clic sur ${widget.titre}');
        },
        onHover: (hovering) {
          setState(() => isHovered = hovering);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: BoxDecoration(
            border: isHovered
                ? const Border(bottom: BorderSide(color: Color(0xFF000091), width: 2))
                : null,
          ),
          child: Center(
            child: Text(
              widget.titre,
              style: const TextStyle(
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
