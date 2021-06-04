import 'package:colorizer/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets.dart';

class OnboardingColumn extends StatelessWidget {
  const OnboardingColumn({
    Key? key,
    // required this.colorFiltered,
  }) : super(key: key);
  // final Widget colorFiltered;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imgs/icon.png',
            height: 50,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Image Colorizer',
            style: TextStyle(
                fontFamily: GoogleFonts.lobster().fontFamily, fontSize: 24),
          ),
          SizedBox(
            height: 48,
          ),
          AppCard(
            image: Image.asset(
              'assets/imgs/onboarding.jpg',
              width: MediaQuery.of(context).size.width / 1.2,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Colorize Your Old Photos',
            style: TextStyle(
                fontFamily: GoogleFonts.lobster().fontFamily, fontSize: 18),
          ),
          SizedBox(
            height: 48,
          ),
          ElevatedButton.icon(
            key: Key('Onboarding Button'),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Home()));
            },
            icon: Icon(Icons.color_lens_outlined),
            label: Text('START NOW'),
          )
        ],
      ),
    );
  }
}
