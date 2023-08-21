import 'package:akademik_app/data/controller/kelas_controller.dart';
import 'package:akademik_app/ui/screen/kelas/detail_kelas_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class KelasScreen extends StatefulWidget {
  const KelasScreen({super.key});

  @override
  State<KelasScreen> createState() => _KelasScreenState();
}

class _KelasScreenState extends State<KelasScreen> {
  final KelasController _kelasController = Get.put(KelasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Data Kelas',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () {
          if (_kelasController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_kelasController.error.value.isNotEmpty) {
            return Text(_kelasController.error.value);
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: _kelasController.kelas.length,
                itemBuilder: (context, index) {
                  var data = _kelasController.kelas[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          DetailKelasScreen(
                            kelas: data,
                          ),
                        );
                      },
                      title: Text(data.departemen.nama),
                      subtitle: Text(data.nama),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
