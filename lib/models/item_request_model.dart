// lib/models/item_request_model.dart

class ItemRequestModel {
  final int requestId;
  final int? itemId;
  final String requesterLogoUrl;
  final String itemName;
  final String recipient;
  final String location;

  ItemRequestModel({
    required this.requestId,
    this.itemId,
    required this.requesterLogoUrl,
    required this.itemName,
    required this.recipient,
    required this.location,
  });
}

class ItemRequestModelDetail extends ItemRequestModel {
  final String quantity;
  final String description;

  ItemRequestModelDetail({
    required super.requestId,
    super.itemId,
    required super.requesterLogoUrl,
    required super.itemName,
    required super.recipient,
    required super.location,
    required this.quantity,
    required this.description,
  });
}
