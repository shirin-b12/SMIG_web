import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smig_web/widgets/custom_top_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _opacity1 = 0.0;
  double _opacity2 = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 5), () {
      setState(() {
        _opacity1 = 1.0;
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity2 = 1.0;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double marginPercentage = 0.1;  // 10% margin on each side
    double containerWidth = screenWidth - (screenWidth * marginPercentage * 2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
            width: containerWidth,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * marginPercentage),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: _opacity1,
                    duration: Duration(seconds: 2),
                    child: Image.network(
                      'assets/firstPage/all-together.png',
                      width: 450,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        AnimatedOpacity(
                          opacity: _opacity1,
                          duration: Duration(seconds: 2),
                          child: const Text(
                            'Quèsaco ?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Marianne',
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF03989E),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),  // Space between texts
                        const Text(
                          'Initiée par le ministère des Solidarités et de la Santé, '
                              'la plateforme (RE)Sources Relationnelles a pour objectif '
                              'de renforcer les liens sociaux et d\'améliorer la qualité de vie des citoyens. '
                              'Ce projet vise à fournir un accès simplifié à des ressources qui facilitent '
                              'et enrichissent les interactions sociales.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Marianne',
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 50),
              Container(
                color: Color(0xFFFCF9EB),
                width: screenWidth,
                height: 250,
                child: Container(
                  width: containerWidth,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * marginPercentage),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Le ministère et ses missions',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Marianne',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '\nLe ministère des Solidarités et de la Santé est chargé de la mise en œuvre'
                                    ' des politiques gouvernementales dans les domaines de la santé publique'
                                    ' et de la solidarité sociale. Sa mission principale est de garantir l\'accès'
                                    ' à des soins de qualité pour tous les citoyens, de promouvoir des politiques'
                                    ' de prévention en santé, et de lutter contre les inégalités sociales et territoriales'
                                    ' d\'accès aux soins. Le ministère veille également à la protection sociale'
                                    ' et à l\'amélioration de la qualité de vie des populations les plus vulnérables.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Marianne',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SvgPicture.asset(
                          'assets/firstPage/hotel-Beauvau-home.svg',
                          width: 350,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: containerWidth,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * marginPercentage),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Expanded(
                    child: Text(
                        'Notre plateforme optimise la cohésion sociale en fournissant '
                            'un accès facile à des ressources qui enrichissent les relations personnelles'
                            ' et professionnelles. Grâce à une interface intuitive, elle favorise un '
                            'environnement inclusif où les utilisateurs de tous âges et situations sociales'
                            ' peuvent partager et apprendre les uns des autres, renforçant ainsi les réseaux'
                            ' de soutien et contribuant à une société plus unie.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Marianne',
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _opacity2,
                    duration: Duration(seconds: 2),
                    child: Image.network(
                      'assets/firstPage/computer.png',
                      width: 450,
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
