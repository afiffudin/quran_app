// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/colors/app_colors.dart';
import 'package:quran/models/ayat.dart';
import 'package:quran/models/surah.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  get gray => null;

  get primary => null;

  get text => null;

  get background => null;

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurat");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
        future: _getDetailSurah(),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            // ignore: prefer_typing_uninitialized_variables
            var background;
            return Scaffold(
              backgroundColor: background,
            );
          }
          Surah surah = snapshot.data!;
          // ignore: prefer_typing_uninitialized_variables
          var background;
          return Scaffold(
            backgroundColor: background,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _details(surah: surah),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) => _ayatItem(
                      ayat: surah.ayat!
                          .elementAt(index + (noSurat == 1 ? 1 : 0))),
                  itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                  separatorBuilder: (context, index) => Container(),
                ),
              ),
            ),
          );
        }));
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: gray, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                        child: Text(
                      '${ayat.nomor}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    )),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share_outlined,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Color.fromARGB(255, 4, 4, 4),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.bookmark_outline,
                    color: Color.fromARGB(255, 5, 5, 5),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style: GoogleFonts.amiri(
                  color: Color.fromARGB(255, 4, 4, 4),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(color: text, fontSize: 16),
            )
          ],
        ),
      );

  Widget _details({required Surah surah}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(children: [
          Container(
            height: 257,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,
                      .6,
                      1
                    ],
                    colors: [
                      Color(0xFFDF98FA),
                      Color(0xFFB070FD),
                      Color(0xFF9055FF)
                    ])),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    'assets/svgs/quran.svg',
                    width: 324 - 55,
                  ))),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text(
                  surah.namaLatin,
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 7, 7, 7),
                      fontWeight: FontWeight.w500,
                      fontSize: 26),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  surah.arti,
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 10, 10, 10),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Divider(
                  color: Color.fromARGB(255, 8, 8, 8).withOpacity(.35),
                  thickness: 2,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surah.tempatTurun.name,
                      style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 8, 8, 8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${surah.jumlahAyat} Ayat",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SvgPicture.asset('assets/svgs/bismillah.svg')
              ],
            ),
          )
        ]),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
              onPressed: (() => Navigator.of(context).pop()),
              icon: SvgPicture.asset('assets/svgs/back-icon.svg')),
          const SizedBox(
            width: 24,
          ),
          Text(
            surah.namaLatin,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              onPressed: (() => {}),
              icon: SvgPicture.asset('assets/svgs/search-icon.svg')),
        ]),
      );
}
