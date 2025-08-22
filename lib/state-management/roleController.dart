import 'package:get/get.dart';

class RoleController extends GetxController {
  // Reactive variable
  final selectedRole = 'Donatur'.obs;

  // List opsi role
  final roles = ['Donatur', 'Penerima Donasi'];

  // Method untuk mengubah role
  void setRole(String? role) {
    if (role != null) selectedRole.value = role;
  }
}
