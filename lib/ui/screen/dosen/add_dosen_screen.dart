import 'package:akademik_app/data/controller/dosen_controller.dart';
import 'package:akademik_app/data/model/dosen/dosen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDosenScreen extends StatefulWidget {
  const AddDosenScreen({super.key});

  @override
  State<AddDosenScreen> createState() => _AddDosenScreenState();
}

class _AddDosenScreenState extends State<AddDosenScreen> {
  final CreateDosenController _createDosenController = Get.put(CreateDosenController());

  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Add Dosen',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () {
          if (_createDosenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_createDosenController.error.isNotEmpty) {
            return Center(
              child: Text(_createDosenController.error.value),
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
            _createDosenController.createDosen(
              DosenModel(
                nip: nipController.text,
                nama: namaController.text,
              ),
            );
            print('NIP : ${nipController.text}');
            print('NAMA : ${namaController.text}');

            // Future.delayed(Duration.zero, () {
            //   Get.off(() => HomePageScreen());
            // });
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
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
