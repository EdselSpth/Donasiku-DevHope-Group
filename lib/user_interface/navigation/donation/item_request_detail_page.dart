import 'package:donasiku/models/item_request_model.dart'; 
import 'package:donasiku/services/request_service.dart';
import 'package:flutter/material.dart';

class ItemRequestDetailPage extends StatefulWidget {
  final ItemRequestModelDetail request;

  const ItemRequestDetailPage({super.key, required this.request});

  @override
  State<ItemRequestDetailPage> createState() => _ItemRequestDetailPageState();
}

class _ItemRequestDetailPageState extends State<ItemRequestDetailPage> {
  final RequestService requestService = RequestService();
  bool _isLoading = false;

  void _approveRequest() async {
    if (widget.request.itemId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This request is not linked to an item.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await requestService.approveRequest(widget.request.requestId, widget.request.itemId!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request approved successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve request: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D2C63),
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Detail Permintaan Barang',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 24),
            const Text(
              'Detail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(widget.request.requesterLogoUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.request.itemName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Penerima : ${widget.request.recipient}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  Text(
                    'Lokasi : ${widget.request.location}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage(widget.request.requesterLogoUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.request.recipient,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            const Text(
              'Detail Permintaan Barang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Nama Barang', widget.request.itemName),
            _buildDetailRow('Jumlah/Kebutuhan', widget.request.quantity),
            _buildDetailRow('Deskripsi Tambahan', widget.request.description),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D2C63),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Batal'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : _approveRequest,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0D2C63),
                  side: const BorderSide(color: Color(0xFF0D2C63), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D2C63)),
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
