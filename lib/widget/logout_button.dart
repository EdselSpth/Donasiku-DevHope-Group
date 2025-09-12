import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  // Membuat fungsi onPressed sebagai parameter yang wajib diisi.
  // Ini memungkinkan logika logout ditentukan di halaman mana pun yang menggunakan tombol ini.
  final VoidCallback onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // Gunakan fungsi onPressed dari parameter
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D2C63),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Keluar Akun', style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
            Icon(Icons.logout, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
