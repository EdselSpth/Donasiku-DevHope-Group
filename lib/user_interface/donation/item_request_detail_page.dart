import 'package:donasiku/models/item_request_model.dart';
import 'package:flutter/material.dart';

class ItemRequestDetailPage extends StatelessWidget {
  final ItemRequestModel request;

  const ItemRequestDetailPage({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(request.itemName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recipient: ${request.recipient}'),
            Text('Location: ${request.location}'),
            // Add more details if they exist in the model
          ],
        ),
      ),
    );
  }
}
