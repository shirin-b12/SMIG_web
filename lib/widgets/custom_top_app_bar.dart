import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../services/auth_service.dart';
import '../views/page/home_page.dart';
import '../views/screen/BarreDeMenu.dart';
import '../views/screen/LottieIconButton.dart';

import 'package:url_launcher/url_launcher.dart';

import '../views/screen/signup_or_login/signup_or_login.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {

  const CustomTopAppBar({Key? key}) : super(key: key);

  @override
  _CustomTopAppBarState createState() => _CustomTopAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(200.0);
}
  class _CustomTopAppBarState extends State<CustomTopAppBar> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1)); // Exemple de durée
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double marginPercentage = 0.05;
    double containerWidth = screenWidth - (screenWidth * marginPercentage * 2);
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return PreferredSize(
      preferredSize: Size(screenWidth, isLandscape ? 120.0 : 200.0), // Adjust the height according to orientation
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  width: containerWidth,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15, left: screenWidth * 0.03, right: 3, top: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset('assets/smig/logo_carre.png', height: 110, width: 110),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: screenWidth * 0.02),
                          child: InkWell(
                            child: const Text(
                              'Ministère des Solidarités et de la Santé',
                              style: TextStyle(
                                fontFamily: 'Marianne',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () async {
                              const url = 'https://google.com';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomSearchBar(),
                      Container(
                        margin: EdgeInsets.only(right: 30, left: 5, top: 15),
                        child: GestureDetector(
                          onTap: () async {
                            _controller
                              ..reset()
                              ..forward();
                            bool isLoggedIn = await AuthService.isLoggedIn();
                            if (isLoggedIn) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                            } else {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpOrLogin()));
                            }
                          },
                          child: Lottie.asset(
                            'assets/appBar/user.json',
                            width: 40,
                            height: 40,
                            controller: _controller,
                            onLoaded: (composition) {
                              _controller
                                ..duration = composition.duration
                                ..forward();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BarreDeMenu(),
              ],
            );
          },
        ),
      ),
    );
  }
}
class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TextField(
        cursorColor: Color(0xFF000091),
        decoration: InputDecoration(
          hintText: 'Rechercher...',
          suffixIcon: Icon(Icons.search, color: Color(0xFF000091)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3.0,color: Color(0xFF000091)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF000091)),
          ),
        ),
      ),
    );
  }
}


