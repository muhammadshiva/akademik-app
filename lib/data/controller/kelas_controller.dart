import 'package:akademik_app/data/model/kelas/kelas_model.dart';
import 'package:akademik_app/data/repositories/kelas_repository.dart';
import 'package:get/get.dart';

class KelasController extends GetxController {
  var kelas = <KelasModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchKelas();
  }

  Future<void> fetchKelas() async {
    try {
      isLoading.value = true;
      var kelasData = await KelasRepository().fetchKelas();
      kelas.assignAll(kelasData);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
