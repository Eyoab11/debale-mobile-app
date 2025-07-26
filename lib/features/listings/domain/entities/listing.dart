import 'package:debale/features/auth/domain/entities/user.dart';

enum RoomType { private, shared, master, studio }

enum PropertyType { apartment, house, villa, studio }

enum AvailabilityStatus { available, rented, pending }

class Listing {
  final String id;
  final String providerId;
  final String title;
  final String description;
  final PropertyType propertyType;
  final RoomType roomType;
  final double monthlyRent;
  final double? depositAmount;
  final String location;
  final double latitude;
  final double longitude;
  final List<String> amenities; // ['wifi', 'kitchen', 'laundry', 'parking']
  final int numberOfRoommates;
  final List<String> currentRoommates; // User IDs
  final Gender? preferredGender;
  final int? preferredAgeMin;
  final int? preferredAgeMax;
  final List<Occupation>? preferredOccupations;
  final List<Religion>? preferredReligions;
  final bool allowsSmoking;
  final bool allowsPets;
  final String houseRules;
  final DateTime availableFrom;
  final AvailabilityStatus status;
  final int views;
  final int inquiries;
  final double? compatibilityScore;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Listing({
    required this.id,
    required this.providerId,
    required this.title,
    required this.description,
    required this.propertyType,
    required this.roomType,
    required this.monthlyRent,
    this.depositAmount,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.amenities = const [],
    this.numberOfRoommates = 0,
    this.currentRoommates = const [],
    this.preferredGender,
    this.preferredAgeMin,
    this.preferredAgeMax,
    this.preferredOccupations,
    this.preferredReligions,
    this.allowsSmoking = false,
    this.allowsPets = false,
    this.houseRules = '',
    required this.availableFrom,
    this.status = AvailabilityStatus.available,
    this.views = 0,
    this.inquiries = 0,
    this.compatibilityScore,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor from Supabase data
  factory Listing.fromSupabase(Map<String, dynamic> data) {
    return Listing(
      id: data['id'] ?? '',
      providerId: data['provider_id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      propertyType: PropertyType.values.firstWhere(
        (e) => e.name == data['property_type'],
        orElse: () => PropertyType.apartment,
      ),
      roomType: RoomType.values.firstWhere(
        (e) => e.name == data['room_type'],
        orElse: () => RoomType.private,
      ),
      monthlyRent: (data['monthly_rent'] ?? 0).toDouble(),
      depositAmount: data['deposit_amount']?.toDouble(),
      location: data['location'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      amenities: data['amenities'] != null 
          ? List<String>.from(data['amenities'])
          : [],
      numberOfRoommates: data['number_of_roommates'] ?? 0,
      currentRoommates: data['current_roommates'] != null 
          ? List<String>.from(data['current_roommates'])
          : [],
      preferredGender: data['preferred_gender'] != null 
          ? Gender.values.firstWhere(
              (e) => e.name == data['preferred_gender'],
              orElse: () => Gender.other,
            )
          : null,
      preferredAgeMin: data['preferred_age_min'],
      preferredAgeMax: data['preferred_age_max'],
      preferredOccupations: data['preferred_occupations'] != null 
          ? (data['preferred_occupations'] as List)
              .map((e) => Occupation.values.firstWhere(
                    (o) => o.name == e,
                    orElse: () => Occupation.other,
                  ))
              .toList()
          : null,
      preferredReligions: data['preferred_religions'] != null 
          ? (data['preferred_religions'] as List)
              .map((e) => Religion.values.firstWhere(
                    (r) => r.name == e,
                    orElse: () => Religion.none,
                  ))
              .toList()
          : null,
      allowsSmoking: data['allows_smoking'] ?? false,
      allowsPets: data['allows_pets'] ?? false,
      houseRules: data['house_rules'] ?? '',
      availableFrom: DateTime.parse(data['available_from']),
      status: AvailabilityStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => AvailabilityStatus.available,
      ),
      views: data['views'] ?? 0,
      inquiries: data['inquiries'] ?? 0,
      compatibilityScore: data['compatibility_score']?.toDouble(),
      isActive: data['is_active'] ?? true,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  // Convert to Supabase data
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'provider_id': providerId,
      'title': title,
      'description': description,
      'property_type': propertyType.name,
      'room_type': roomType.name,
      'monthly_rent': monthlyRent,
      'deposit_amount': depositAmount,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'amenities': amenities,
      'number_of_roommates': numberOfRoommates,
      'current_roommates': currentRoommates,
      'preferred_gender': preferredGender?.name,
      'preferred_age_min': preferredAgeMin,
      'preferred_age_max': preferredAgeMax,
      'preferred_occupations': preferredOccupations?.map((e) => e.name).toList(),
      'preferred_religions': preferredReligions?.map((e) => e.name).toList(),
      'allows_smoking': allowsSmoking,
      'allows_pets': allowsPets,
      'house_rules': houseRules,
      'available_from': availableFrom.toIso8601String(),
      'status': status.name,
      'views': views,
      'inquiries': inquiries,
      'compatibility_score': compatibilityScore,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Listing copyWith({
    String? id,
    String? providerId,
    String? title,
    String? description,
    PropertyType? propertyType,
    RoomType? roomType,
    double? monthlyRent,
    double? depositAmount,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? amenities,
    int? numberOfRoommates,
    List<String>? currentRoommates,
    Gender? preferredGender,
    int? preferredAgeMin,
    int? preferredAgeMax,
    List<Occupation>? preferredOccupations,
    List<Religion>? preferredReligions,
    bool? allowsSmoking,
    bool? allowsPets,
    String? houseRules,
    DateTime? availableFrom,
    AvailabilityStatus? status,
    int? views,
    int? inquiries,
    double? compatibilityScore,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Listing(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      title: title ?? this.title,
      description: description ?? this.description,
      propertyType: propertyType ?? this.propertyType,
      roomType: roomType ?? this.roomType,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      depositAmount: depositAmount ?? this.depositAmount,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      amenities: amenities ?? this.amenities,
      numberOfRoommates: numberOfRoommates ?? this.numberOfRoommates,
      currentRoommates: currentRoommates ?? this.currentRoommates,
      preferredGender: preferredGender ?? this.preferredGender,
      preferredAgeMin: preferredAgeMin ?? this.preferredAgeMin,
      preferredAgeMax: preferredAgeMax ?? this.preferredAgeMax,
      preferredOccupations: preferredOccupations ?? this.preferredOccupations,
      preferredReligions: preferredReligions ?? this.preferredReligions,
      allowsSmoking: allowsSmoking ?? this.allowsSmoking,
      allowsPets: allowsPets ?? this.allowsPets,
      houseRules: houseRules ?? this.houseRules,
      availableFrom: availableFrom ?? this.availableFrom,
      status: status ?? this.status,
      views: views ?? this.views,
      inquiries: inquiries ?? this.inquiries,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 