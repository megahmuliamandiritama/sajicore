class GooglePlaceModel {
  final String description;
  final String id;
  final String placeId;
  final String reference;

  GooglePlaceModel({
    this.description,
    this.id,
    this.placeId,
    this.reference,
  });

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) {
    return GooglePlaceModel(
      description: json['description'] as String,
      id: json['id'] as String,
      placeId: json['place_id'] as String,
      reference: json['reference'] as String,
    );
  }
}