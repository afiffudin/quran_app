import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/colors/app_colors.dart';
import 'package:quran/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran/widgets/language_flag_widget.dart';
import 'package:quran/widgets/languages_picker_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appbar
        title: Text(AppLocalizations.of(context)?.title ?? ''),
        centerTitle: true,
        leading: LanguageFlagWidget(), //bendera bahasa
        actions: [LanguagePickerWidget()], //bahasanya
      ),
      backgroundColor: Color.fromARGB(255, 16, 35, 4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)?.greeting('') ??
                      'My Quran', //ngambil data dari app_id.arb dll
                  style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 250, 3, 3), //warna text font
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)?.invitation_message ??
                      'My Quran',
                  style:
                      GoogleFonts.poppins(fontSize: 18, color: AppColors.text),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 64, 244, 4)),
                      child: SvgPicture.asset('assets/svgs/splash.svg'),
                    ),
                    Positioned(
                      left: 0,
                      bottom: -23,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 251, 133, 83),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              AppLocalizations.of(context)!.opening,
                              // 'My Quran',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
