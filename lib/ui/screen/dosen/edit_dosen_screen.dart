import 'package:akademik_app/data/controller/dosen_controller.dart';
import 'package:akademik_app/data/model/dosen/dosen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDosenScreen extends StatefulWidget {
  final DosenModel dosen;

  const EditDosenScreen({
    super.key,
    required this.dosen,
  });

  @override
  State<EditDosenScreen> createState() => _EditDosenScreenState();
}

class _EditDosenScreenState extends State<EditDosenScreen> {
  final UpdateDosenController _updateDosenController = Get.put(UpdateDosenController());

  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();

  @override
  void initState() {
    nipController.text = widget.dosen.nip;
    namaController.text = widget.dosen.nama;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Dosen',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () {
          if (_updateDosenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_updateDosenController.error.value.isNotEmpty) {
            return Center(
              child: Text(_updateDosenController.error.value),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  TextField(
                    controller: nipController,
                    decoration: const InputDecoration(
                      labelText: 'Nip',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () {
            _updateDosenController.updateDosen(
              DosenModel(nip: nipController.text, nama: namaController.text),
              widget.dosen.id!,
            );
            print('ID : ${widget.dosen.id}');
            print('NIP : ${nipController.text}');
            print('NAMA : ${namaController.text}');
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Simpan',
              style: GoogleFonts.lato().copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
