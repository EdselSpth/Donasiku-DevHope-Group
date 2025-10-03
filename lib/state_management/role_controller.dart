import 'package:get/get.dart';

class RoleController extends GetxController {
  final selectedRole = 'Donatur'.obs;

  final roles = ['Donatur', 'Penerima Donasi'];

  void setRole(String? role) {
    if (role != null) selectedRole.value = role;
  }
}
