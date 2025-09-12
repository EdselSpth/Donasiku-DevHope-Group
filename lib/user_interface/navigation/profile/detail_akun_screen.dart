import 'package:flutter/material.dart';

class DetailAkunScreen extends StatelessWidget {
  const DetailAkunScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // REVISI: Warna background utama agar sesuai mockup
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        // REVISI: Warna AppBar menjadi putih solid
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Detail Akun',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- KARTU INFORMASI AKUN ---
            Text(
              'Informasi Akun',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // REVISI: Warna teks menjadi lebih solid
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              // REVISI: Style Card agar sesuai mockup
              elevation: 4,
              shadowColor: Colors.purple.withOpacity(0.08),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          // TODO: Ganti dengan URL gambar profil dari backend
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=32',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Aksi untuk ganti foto
                            },
                            style: OutlinedButton.styleFrom(
                              // REVISI: Warna tombol dan bentuk
                              foregroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(
                                color: Colors.blueAccent,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Ganti Foto',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        // REVISI: Padding disesuaikan agar rapi
                        padding: const EdgeInsets.only(left: 76.0),
                        child: Text(
                          'Ukuran foto maksimal 5Mb.',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // REVISI: Menggunakan widget baru untuk layout yang sesuai
                    // TODO: Ganti value dengan data nama dari backend
                    _buildInfoRow('Nama Akun', 'Zunadea Kusmiandita'),
                    const SizedBox(height: 16),

                    // TODO: Ganti value & status verifikasi dari backend
                    _buildInfoRowWithVerification('Role Akun', 'Donatur'),
                    const SizedBox(height: 16),

                    // TODO: Ganti value dengan data nomor HP dari backend
                    _buildInfoRowWithIcon('No Handphone', '+6285********56'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- KARTU INFORMASI LAINNYA ---
            Text(
              'Informasi Lainnya',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              // REVISI: Style Card disamakan
              elevation: 4,
              shadowColor: Colors.purple.withOpacity(0.08),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  // TODO: Ganti dengan URL gambar profil dari backend
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=32',
                  ),
                ),
                title: const Text(
                  'Informasi Pribadi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  // TODO: Ganti dengan status kelengkapan data dari backend
                  'Sudah Lengkap',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Aksi ketika item di-tap
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // REVISI TOTAL: Widget bantuan untuk membuat baris informasi (Label di kiri, Value di kanan)
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        const Spacer(), // Mendorong widget berikutnya ke kanan
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  // REVISI TOTAL: Widget bantuan khusus untuk "Role Akun" dengan ikon verifikasi
  Widget _buildInfoRowWithVerification(String label, String value) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.check_circle, color: Colors.blue, size: 16),
        const SizedBox(width: 4),
        const Text(
          'Sudah Verifikasi',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // REVISI TOTAL: Widget bantuan khusus untuk "No Handphone" dengan ikon mata
  Widget _buildInfoRowWithIcon(String label, String value) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(width: 8),
        Icon(Icons.visibility, color: Colors.grey[600], size: 18),
      ],
    );
  }
}
