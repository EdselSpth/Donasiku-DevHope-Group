// lib/models/item_request_model.dart

class ItemRequestModel {
  final String requesterLogoUrl;
  final String itemName;
  final String recipient;
  final String location;

  ItemRequestModel({
    required this.requesterLogoUrl,
    required this.itemName,
    required this.recipient,
    required this.location,
  });
}
