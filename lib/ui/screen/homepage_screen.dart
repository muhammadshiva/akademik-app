import 'package:akademik_app/data/controller/dosen_controller.dart';
import 'package:akademik_app/data/controller/mahasiswa_controller.dart';
import 'package:akademik_app/ui/screen/dosen/add_dosen_screen.dart';
import 'package:akademik_app/ui/screen/dosen/edit_dosen_screen.dart';
import 'package:akademik_app/ui/screen/dosen/detail_dosen_screen.dart';
import 'package:akademik_app/ui/screen/mahasiswa/add_mahasiswa_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with SingleTickerProviderStateMixin {
  // Dosen Controller
  final DosenController _dosenController = Get.put(DosenController());
  final DeleteDosenController _deleteDosenController = Get.put(DeleteDosenController());

  // Mahasiswa Controller
  final MahasiswaController _mahasiswaController = Get.put(MahasiswaController());

  late TabController _tabController;

  int currentTab = 0;

  @override
  void initState() {
    _dosenController.fetchDosen();
    _mahasiswaController.fetchMahasiswa();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      // Ketika tab dipilih, akses nilai indeks tab yang dipilih
      int selectedTabIndex = _tabController.index;
      print('Selected Tab Index: $selectedTabIndex');

      // Lakukan sesuatu berdasarkan indeks tab yang dipilih
      if (selectedTabIndex == 0) {
        setState(() {
          currentTab = 0;
        });
      } else if (selectedTabIndex == 1) {
        setState(() {
          currentTab = 1;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Data User',
          style: GoogleFonts.lato().copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelStyle: GoogleFonts.lato(),
              unselectedLabelStyle: GoogleFonts.lato(),
              tabs: const [
                Tab(
                  text: 'Data Dosen',
                ),
                Tab(
                  text: 'Data Mahasiswa',
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              child: TabBarView(
                controller: _tabController,
                children: [
                  listDosenObx(),
                  listMahasiswaObx(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Current TAB : $currentTab');
          currentTab == 0 ? Get.to(AddDosenScreen()) : Get.to(AddMahasiswaScreen());
          // Get.to(() => AddDosenScreen());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget listDosenObx() {
    return Obx(
      () {
        if (_deleteDosenController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_deleteDosenController.error.value.isNotEmpty) {
          return Center(
            child: Text(_deleteDosenController.error.value),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Obx(
                    () {
                      if (_dosenController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (_dosenController.error.isNotEmpty) {
                        return Center(
                          child: Text(_dosenController.error.value),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: _dosenController.dosen.length,
                          itemBuilder: (context, index) {
                            var dosen = _dosenController.dosen[index];
                            // Tampilkan data dosen
                            return listDosenCard(
                              dosen.nama,
                              dosen.nip,
                              dosen,
                              dosen.id!,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget listDosenCard(String nama, String nip, dosen, int id) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailDosenScreen(
                dosen: dosen,
              ),
            ),
          );
        },
        title: Text(
          nama,
          style: GoogleFonts.lato(),
        ),
        subtitle: Text(
          nip,
          style: GoogleFonts.lato(),
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            // Handle menu item selection here
            if (value == 'Edit') {
              print('edit');
            } else if (value == 'Delete') {
              print('delete');
              Get.back();
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'Edit',
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDosenScreen(
                          dosen: dosen,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      const SizedBox(width: 10),
                      Text('Edit'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Delete',
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: const Text(
                              'Are you sure want to delete this ?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Delete'),
                                onPressed: () {
                                  _deleteDosenController.deleteDosen(id);
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: GoogleFonts.lato().copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }

  Widget listMahasiswaObx() {
    return Obx(
      () {
        if (_mahasiswaController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_mahasiswaController.error.value.isNotEmpty) {
          return Center(
            child: Text(_mahasiswaController.error.value),
          );
        } else {
          return ListView.builder(
            itemCount: _mahasiswaController.mahasiswa.length,
            itemBuilder: (context, index) {
              final data = _mahasiswaController.mahasiswa[index];

              return listMahasiswaCard(data.nama, data.nim, data, data.id!);
            },
          );
        }
      },
    );
  }

  Widget listMahasiswaCard(String nama, String nim, mahasiswa, int id) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailDosenScreen(
          //       dosen: dosen,
          //     ),
          //   ),
          // );
        },
        title: Text(
          nama,
          style: GoogleFonts.lato(),
        ),
        subtitle: Text(
          nim,
          style: GoogleFonts.lato(),
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            // Handle menu item selection here
            if (value == 'Edit') {
              print('edit');
            } else if (value == 'Delete') {
              print('delete');
              Get.back();
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'Edit',
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditDosenScreen(
                    //       dosen: dosen,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      const SizedBox(width: 10),
                      Text('Edit'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Delete',
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: const Text(
                              'Are you sure want to delete this ?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Delete'),
                                onPressed: () {
                                  // _deleteDosenController.deleteDosen(id);
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: GoogleFonts.lato().copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
