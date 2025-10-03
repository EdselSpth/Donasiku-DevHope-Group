import 'package:donasiku/models/donation_item.dart';
import 'package:donasiku/services/donation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:donasiku/user_interface/navigation/history/history_page.dart';

class DonationDetailPage extends StatefulWidget {
  final DonationItem item;
  final String? donationId;

  const DonationDetailPage({Key? key, required this.item, this.donationId})
    : super(key: key);

  @override
  _DonationDetailPageState createState() => _DonationDetailPageState();
}

class _DonationDetailPageState extends State<DonationDetailPage> {
  bool _isLoading = false;
  final DonationService _donationService = DonationService();
  String? _resolvedDonationId;

  Future<void> _approveDonation() async {
    setState(() => _isLoading = true);

    final donationId = _resolvedDonationId ?? widget.donationId;
    if (donationId == null || donationId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Donation ID tidak tersedia untuk disetujui.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      if (kDebugMode) {
        print(
          'DonationDetailPage: item.id=${widget.item.id} resolvedDonationId=$_resolvedDonationId widget.donationId=${widget.donationId}',
        );
        print(
          'DonationDetailPage: attempting updateDonationStatus for donationId: $donationId',
        );
      }

      try {
        final success = await _donationService.updateDonationStatus(
          donationId,
          'completed',
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Donasi berhasil disetujui!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HistoryPage()),
          );
          return;
        }
      } catch (e) {
        final message = e.toString();
        if (message.contains('Donation not found') ||
            message.contains('Donation not found')) {
          if (kDebugMode)
            print(
              'Update returned Donation not found; attempting to re-resolve donation id',
            );
          try {
            final list = await _donationService.getActiveDonations();
            String? foundId;
            for (final h in list) {
              if (h.itemId == widget.item.id) {
                foundId = h.donationId;
                break;
              }
            }
            if (foundId != null && foundId != donationId) {
              if (kDebugMode)
                print('Retrying update with found donationId: $foundId');
              final retrySuccess = await _donationService.updateDonationStatus(
                foundId,
                'completed',
              );
              if (retrySuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Donasi berhasil disetujui (retry)!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
                return;
              }
            }
          } catch (retryErr) {
            if (kDebugMode) print('Retry failed: $retryErr');
          }
        }
        rethrow;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    // If donationId already provided, resolve immediately
    if (widget.donationId != null && widget.donationId!.isNotEmpty) {
      _resolvedDonationId = widget.donationId;
    } else {
      // try to find an active donation that matches this item
      _resolveDonationForItem();
    }
  }

  Future<void> _resolveDonationForItem() async {
    try {
      final list = await _donationService.getActiveDonations();
      for (final h in list) {
        if (h.itemId == widget.item.id) {
          setState(() => _resolvedDonationId = h.donationId);
          break;
        }
      }
    } catch (e) {
      // ignore — leave _resolvedDonationId null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Detail Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Debug banner: show ids involved (debug builds only)
            if (kDebugMode)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Text(
                    'debug: item.id=${widget.item.id} provided=${widget.donationId ?? "null"} resolved=${_resolvedDonationId ?? "null"}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ),
            const Text(
              'Foto Barang',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildPhotoCard(widget.item),
            const SizedBox(height: 24),
            _buildDetailsCard(widget.item),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildPhotoCard(DonationItem item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            item.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.blueAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(DonationItem item) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detail Barang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: const Text(
                    'Donatur',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildDetailRow('Pemilik Barang', item.owner),
            _buildDetailRow('Nama Barang', item.title),
            _buildDetailRow('Deskripsi Barang', item.description),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: const Color(0xFF0D2C63),
                  side: const BorderSide(color: Color(0xFF0D2C63), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Batal'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _approveDonation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF0D2C63),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text('Setujui'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
