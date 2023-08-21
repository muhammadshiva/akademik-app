import 'package:akademik_app/data/controller/mahasiswa_controller.dart';
import 'package:akademik_app/data/model/mahasiswa/mahasiswa_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddMahasiswaScreen extends StatefulWidget {
  const AddMahasiswaScreen({super.key});

  @override
  State<AddMahasiswaScreen> createState() => _AddMahasiswaScreenState();
}

class _AddMahasiswaScreenState extends State<AddMahasiswaScreen> {
  final CreateMahasiswaController _createMahasiswaController = Get.put(CreateMahasiswaController());

  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  DateTime? selectedDate;

  String outputDate = '';
  String backendDate = '';

  String _selectedOption = ''; // Untuk menyimpan opsi yang dipilih

  // Daftar opsi untuk dropdown
  List<String> _options = [
    'Laki-laki',
    'Perempuan',
  ];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String formDate = DateFormat("dd-MM-yyyy").format(picked);
        tanggalLahirController.text = formDate;
        String _backendDate = DateFormat("yyyy-MM-dd").format(picked);
        backendDate = _backendDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Add Mahasiswa',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (_createMahasiswaController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_createMahasiswaController.error.isNotEmpty) {
          return Center(
            child: Text(_createMahasiswaController.error.value),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                textField('Nim', nimController),
                textField('Nama', namaController),
                textField('Tanggal Lahir', tanggalLahirController),
                textField('Alamat', alamatController),
                dropdownGender(),
              ],
            ),
          );
        }
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () {
            print('NIM : ${nimController.text}');
            print('Nama : ${namaController.text}');
            print('Tanggal Lahir : $backendDate');
            print('Alamat : ${alamatController.text}');
            print('Gender : $_selectedOption');

            _createMahasiswaController.createMahasiswa(
              MahasiswaModel(
                nim: nimController.text,
                nama: namaController.text,
                tglLahir: backendDate,
                alamat: alamatController.text,
                gender: _selectedOption,
              ),
            );
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

  Widget textField(String label, TextEditingController controller) {
    return InkWell(
      onTap: () {
        label == "Tanggal Lahir" ? _selectDate(context) : {};
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: TextField(
          keyboardType: label == "Tanggal Lahir" ? TextInputType.none : TextInputType.text,
          controller: controller,
          enabled: label == "Tanggal Lahir" ? false : true,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: label,
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: label == "Tanggal Lahir"
                  ? Icon(Icons.calendar_month)
                  : label == "Gender"
                      ? Icon(Icons.arrow_drop_down)
                      : Container(),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownGender() {
    return DropdownButtonFormField<String>(
      value: _selectedOption.isNotEmpty ? _selectedOption : null, // Nilai yang terpilih
      items: _options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        // Callback ini akan dipanggil ketika pengguna memilih opsi
        setState(() {
          _selectedOption = value!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Gender', // Label untuk TextField
        border: OutlineInputBorder(), // Outline border seperti TextField biasa
      ),
    );
  }
}
