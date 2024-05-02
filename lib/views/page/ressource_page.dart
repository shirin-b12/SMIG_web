import 'package:flutter/material.dart';
import 'package:smig_web/services/auth_service.dart';
import 'package:smig_web/views/page/ressource_modification_page.dart';
import '../../../models/commentaire.dart';
import '../../../models/ressource.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_top_app_bar.dart';
import '../../../widgets/ressource_card.dart';

class RessourcePage extends StatefulWidget {
  final int resourceId;

  RessourcePage({required this.resourceId});

  @override
  _RessourcePageState createState() => _RessourcePageState();
}
class _RessourcePageState extends State<RessourcePage> {

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    // Define the theme colors
    final Color primaryColor = Color(0xFF03989E);
    final Color secondaryColor = Color(0xFF015E62);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor, // Use primary color here
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              final TextEditingController commentController = TextEditingController();
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        labelText: 'Votre commentaire',
                        labelStyle: TextStyle(color: secondaryColor), // Use secondary color for label
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor), // Use primary color for focus
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: primaryColor, // Text color
                      ),
                      child: Text('Envoyer'),
                      onPressed: () async {
                        int userId = await AuthService().getCurrentUser();
                        api.createComment(commentController.text, userId, widget.resourceId, 0);
                        api.fetchComments(widget.resourceId);
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add_comment),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Ressource>(
              future: api.getRessource(widget.resourceId),
              builder: (context, snapshotRessource) {
                if (snapshotRessource.connectionState == ConnectionState.done) {
                  if (snapshotRessource.hasData) {
                    return ListView(
                      children: <Widget>[
                        RessourceCard(ressource: snapshotRessource.data!),
                        IconButton(
                          icon: Icon(Icons.edit, color: Color(0xFF03989E)),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RessourceUpdatePage(ressourceId: widget.resourceId,)));
                          },
                        ),
                        FutureBuilder<List<Commentaire>>(
                          future: api.fetchComments(widget.resourceId),
                          builder: (context, snapshotComments) {
                            if (snapshotComments.connectionState == ConnectionState.done) {
                              if (snapshotComments.hasData) {
                                return Column(
                                  children: snapshotComments.data!.map((comment) => ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${comment.utilisateurRedacteur?.nom} ${comment.utilisateurRedacteur?.prenom}",
                                            style: TextStyle(color: secondaryColor)),
                                        Text(comment.commentaire),
                                      ],
                                    ),
                                    subtitle: Text("Poste le : ${comment.dateDeCreation}",
                                        style: TextStyle(fontSize: 10)),
                                  )).toList(),
                                );
                              } else if (snapshotComments.hasError) {
                                return Text("Erreur: ${snapshotComments.error}");
                              }
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    );
                  } else if (snapshotRessource.hasError) {
                    return Text("Erreur: ${snapshotRessource.error}");
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}