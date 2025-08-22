import 'package:donasiku/user-interface/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donasiku/state-management/roleController.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil controller yang sudah di-inject
    final rc = Get.find<RoleController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Image.asset(
                  'Assets/Logo-Donasiku.png',
                  height: 45,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Daftar',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Daftar untuk mengakses fitur aplikasi Donasiku',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 24),
              const Text('Username'),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Masukan username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Password'),
              const SizedBox(height: 5),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukan password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Role'),
              const SizedBox(height: 5),

              Obx(() {
                return DropdownButtonFormField<String>(
                  value: rc.selectedRole.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items:
                      rc.roles
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ),
                          )
                          .toList(),
                  onChanged: rc.setRole,
                );
              }),

              const SizedBox(height: 5),
              Row(
                children: [
                  const Text("Sudah punya akun?"),
                  const SizedBox(width: 3),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      "silahkan masuk",
                      style: TextStyle(color: Color(0xFF00306C)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D2C63), // biru navy
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "MASUK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
