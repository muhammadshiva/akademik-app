import 'package:akademik_app/data/model/departemen/departemen_model.dart';
import 'package:akademik_app/data/model/kelas/kelas_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailKelasScreen extends StatefulWidget {
  final KelasModel kelas;

  const DetailKelasScreen({super.key, required this.kelas});

  @override
  State<DetailKelasScreen> createState() => _DetailKelasScreenState();
}

class _DetailKelasScreenState extends State<DetailKelasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Detail Data Kelas',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.kelas.departemen.nama,
            ),
            Text(
              widget.kelas.nama,
            ),
          ],
        ),
      ),
    );
  }
}
