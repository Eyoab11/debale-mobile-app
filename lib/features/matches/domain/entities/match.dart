enum MatchStatus { pending, accepted, rejected, expired }

class Match {
  final String id;
  final String seekerId;
  final String providerId;
  final String listingId;
  final double compatibilityScore;
  final MatchStatus status;
  final String? message;
  final DateTime? acceptedAt;
  final DateTime? rejectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Match({
    required this.id,
    required this.seekerId,
    required this.providerId,
    required this.listingId,
    required this.compatibilityScore,
    required this.status,
    this.message,
    this.acceptedAt,
    this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor from Supabase data
  factory Match.fromSupabase(Map<String, dynamic> data) {
    return Match(
      id: data['id'] ?? '',
      seekerId: data['seeker_id'] ?? '',
      providerId: data['provider_id'] ?? '',
      listingId: data['listing_id'] ?? '',
      compatibilityScore: (data['compatibility_score'] ?? 0).toDouble(),
      status: MatchStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => MatchStatus.pending,
      ),
      message: data['message'],
      acceptedAt: data['accepted_at'] != null 
          ? DateTime.parse(data['accepted_at'])
          : null,
      rejectedAt: data['rejected_at'] != null 
          ? DateTime.parse(data['rejected_at'])
          : null,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  // Convert to Supabase data
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'seeker_id': seekerId,
      'provider_id': providerId,
      'listing_id': listingId,
      'compatibility_score': compatibilityScore,
      'status': status.name,
      'message': message,
      'accepted_at': acceptedAt?.toIso8601String(),
      'rejected_at': rejectedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Match copyWith({
    String? id,
    String? seekerId,
    String? providerId,
    String? listingId,
    double? compatibilityScore,
    MatchStatus? status,
    String? message,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Match(
      id: id ?? this.id,
      seekerId: seekerId ?? this.seekerId,
      providerId: providerId ?? this.providerId,
      listingId: listingId ?? this.listingId,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      status: status ?? this.status,
      message: message ?? this.message,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 