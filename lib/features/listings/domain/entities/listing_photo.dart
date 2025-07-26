class ListingPhoto {
  final String id;
  final String listingId;
  final String photoUrl;
  final String? caption;
  final int displayOrder;
  final DateTime createdAt;

  const ListingPhoto({
    required this.id,
    required this.listingId,
    required this.photoUrl,
    this.caption,
    this.displayOrder = 0,
    required this.createdAt,
  });

  // Factory constructor from Supabase data
  factory ListingPhoto.fromSupabase(Map<String, dynamic> data) {
    return ListingPhoto(
      id: data['id'] ?? '',
      listingId: data['listing_id'] ?? '',
      photoUrl: data['photo_url'] ?? '',
      caption: data['caption'],
      displayOrder: data['display_order'] ?? 0,
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  // Convert to Supabase data
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'listing_id': listingId,
      'photo_url': photoUrl,
      'caption': caption,
      'display_order': displayOrder,
      'created_at': createdAt.toIso8601String(),
    };
  }

  ListingPhoto copyWith({
    String? id,
    String? listingId,
    String? photoUrl,
    String? caption,
    int? displayOrder,
    DateTime? createdAt,
  }) {
    return ListingPhoto(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      photoUrl: photoUrl ?? this.photoUrl,
      caption: caption ?? this.caption,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 