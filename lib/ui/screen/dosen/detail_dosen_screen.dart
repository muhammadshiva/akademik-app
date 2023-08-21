import 'package:akademik_app/data/model/dosen/dosen_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailDosenScreen extends StatefulWidget {
  final DosenModel dosen;

  const DetailDosenScreen({
    super.key,
    required this.dosen,
  });

  @override
  State<DetailDosenScreen> createState() => _DetailDosenScreenState();
}

class _DetailDosenScreenState extends State<DetailDosenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Dosen',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(widget.dosen.nama),
          ],
        ),
      ),
    );
  }
}
