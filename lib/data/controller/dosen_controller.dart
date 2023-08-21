import 'package:akademik_app/data/model/dosen/dosen_model.dart';
import 'package:akademik_app/data/repositories/dosen_repository.dart';
import 'package:akademik_app/ui/screen/homepage_screen.dart';
import 'package:akademik_app/ui/screen/success_screen.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DosenController extends GetxController {
  var dosen = <DosenModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDosen();
  }

  Future<void> fetchDosen() async {
    try {
      isLoading.value = true;
      var dosenData = await DosenRepository().fetchDosen();
      dosen.assignAll(dosenData);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

class CreateDosenController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> createDosen(DosenModel data) async {
    try {
      isLoading.value = true;
      error.value = '';
      await DosenRepository().createDosen(data);
      print('Create Dosen Success From Controller');

      // Navigate to another page if success
      Get.offAll(SuccessScreen());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

class UpdateDosenController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> updateDosen(DosenModel data, int id) async {
    try {
      isLoading.value = true;
      error.value = '';
      await DosenRepository().updateDosen(data, id);
      print('Update Data Dosen Success');

      Get.offAll(SuccessScreen());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

class DeleteDosenController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> deleteDosen(int id) async {
    try {
      isLoading.value = true;
      error.value = '';
      await DosenRepository().deleteDosen(id);
      print('Delete Data Success');

      Get.offAll(HomePageScreen());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
