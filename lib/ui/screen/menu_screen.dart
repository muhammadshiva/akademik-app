import 'package:akademik_app/ui/screen/homepage_screen.dart';
import 'package:akademik_app/ui/screen/kelas/departemen_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Main Menu',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            menuButton(
              'Data Dosen dan Mahasiswa',
              onPressed: () {
                Get.to(HomePageScreen());
              },
            ),
            menuButton(
              'Data Departemen',
              onPressed: () {
                Get.to(DepartemenScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuButton(String title, {required Null Function() onPressed}) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
