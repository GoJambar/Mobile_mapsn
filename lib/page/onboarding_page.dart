import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mapsn/page/home_page.dart';
import 'package:mapsn/widget/bootomBar.dart';
import 'package:mapsn/widget/button_widget.dart';
import 'package:mapsn/widget/splashsreen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Eksil ak jàmm',
              body: "Découvrons le Sénégal ensemble.",
              image: buildImage('assets/images/bienvenue.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Circonscription Administrative',
              body: "Un portail d'informations sur le Sénégal",
              image: buildImage('assets/images/essay.jpg'),
              decoration: getPageDecoration(),
            ),
            /*PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced reading experience',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),*/
            PageViewModel(
              title: 'Circonscription Administrative',
              body:
                  'Vous pouvez parcourir pour en savoir plus sur chaque région',
              footer: ButtonWidget(
                text: 'Commencer',
                onClicked: () => goToHome(context),
              ),
              image: buildImage('assets/images/im6.jpg'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Read', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip'),
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Splash()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
