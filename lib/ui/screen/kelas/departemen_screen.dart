import 'package:akademik_app/data/controller/departemen_controller.dart';
import 'package:akademik_app/ui/screen/kelas/kelas_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DepartemenScreen extends StatefulWidget {
  const DepartemenScreen({super.key});

  @override
  State<DepartemenScreen> createState() => _DepartemenScreenState();
}

class _DepartemenScreenState extends State<DepartemenScreen> {
  final DepartemenController _departemenController = Get.put(DepartemenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Data Departemen',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () {
          if (_departemenController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_departemenController.error.value.isNotEmpty) {
            return Text(_departemenController.error.value);
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 500,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: _departemenController.departemen.length,
                  itemBuilder: (context, index) {
                    var data = _departemenController.departemen[index];
                    return cardDepartment(
                      data.kode,
                      data.nama,
                      onTap: () {
                        Get.to(KelasScreen());
                      },
                    );
                  },
                ),
              ),
              // child: ListView(
              //   children: [
              //     cardDepartment(
              //       'TI',
              //       'Teknologi Informasi',
              //       onTap: () {
              //         Get.to(KelasScreen());
              //       },
              //     ),
              //   ],
              // ),
            );
          }
        },
      ),
    );
  }

  Widget cardDepartment(String title, String subtitle, {required Null Function() onTap}) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: GoogleFonts.lato(),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.lato(),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
      ),
    );
  }
}
