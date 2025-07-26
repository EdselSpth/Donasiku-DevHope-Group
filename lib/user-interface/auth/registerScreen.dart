import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
              TextField(
                decoration: InputDecoration(
                  hintText: "Masukan username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Password'),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "Masukan password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Role'),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
