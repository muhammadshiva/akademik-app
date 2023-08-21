import 'package:akademik_app/ui/screen/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Data berhasil diupdate',
              style: GoogleFonts.lato().copyWith(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(),
                  ),
                );
              },
              child: Text('Homepage'),
            ),
          ],
        ),
      ),
    );
  }
}
