import 'package:akademik_app/data/model/mahasiswa/mahasiswa_model.dart';
import 'package:akademik_app/data/repositories/mahasiswa_repository.dart';
import 'package:get/get.dart';
import 'package:akademik_app/ui/screen/success_screen.dart';

class MahasiswaController extends GetxController {
  var mahasiswa = <MahasiswaModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMahasiswa();
  }

  Future<void> fetchMahasiswa() async {
    try {
      isLoading.value = true;
      var mahasiswaData = await MahasiswaRepository().fetchMahasiswa();
      mahasiswa.assignAll(mahasiswaData);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

class CreateMahasiswaController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> createMahasiswa(MahasiswaModel data) async {
    try {
      isLoading.value = true;
      await MahasiswaRepository().createMahasiswa(data);
      print('Create Mahasiswa Success Controller');
      Get.offAll(SuccessScreen());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

class UpdateMahasiswaController extends GetxController {}

class DeleteMahasiswaController extends GetxController {}
