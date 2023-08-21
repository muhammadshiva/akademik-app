import 'package:akademik_app/data/model/departemen/departemen_model.dart';
import 'package:akademik_app/data/repositories/departemen_repository.dart';
import 'package:get/get.dart';

class DepartemenController extends GetxController {
  var departemen = <DepartemenModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDepartemen();
  }

  Future<void> fetchDepartemen() async {
    try {
      isLoading.value = true;
      var departemenData = await DepartemenRepository().fetchDepartemen();
      departemen.assignAll(departemenData);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
