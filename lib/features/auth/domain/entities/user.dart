enum ProfileType { seeker, provider }

enum Gender { male, female, other }

enum Religion { orthodox, muslim, protestant, catholic, other, none }

enum Occupation { student, professional, business, other }

class User {
  final String id;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final ProfileType? profileType;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String? profilePhotoUrl;
  final String? currentLocation;
  final String? preferredAreas;
  final double? budgetMin;
  final double? budgetMax;
  final DateTime? moveInDate;
  final List<String> languages; // ['am', 'en', 'om']
  final bool? isSmoker;
  final bool? hasPets;
  final String? noiseTolerance; // 'quiet', 'moderate', 'social'
  final Religion? religion;
  final Occupation? occupation;
  final String? studyField; // For students
  final String? employer; // For professionals
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.profileType,
    this.dateOfBirth,
    this.gender,
    this.profilePhotoUrl,
    this.currentLocation,
    this.preferredAreas,
    this.budgetMin,
    this.budgetMax,
    this.moveInDate,
    this.languages = const ['en'],
    this.isSmoker,
    this.hasPets,
    this.noiseTolerance,
    this.religion,
    this.occupation,
    this.studyField,
    this.employer,
    this.isVerified = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor from Supabase data
  factory User.fromSupabase(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      fullName: data['full_name'],
      phoneNumber: data['phone_number'],
      profileType: data['profile_type'] != null 
          ? ProfileType.values.firstWhere(
              (e) => e.name == data['profile_type'],
              orElse: () => ProfileType.seeker,
            )
          : null,
      dateOfBirth: data['date_of_birth'] != null 
          ? DateTime.parse(data['date_of_birth'])
          : null,
      gender: data['gender'] != null 
          ? Gender.values.firstWhere(
              (e) => e.name == data['gender'],
              orElse: () => Gender.other,
            )
          : null,
      profilePhotoUrl: data['profile_photo_url'],
      currentLocation: data['current_location'],
      preferredAreas: data['preferred_areas'],
      budgetMin: data['budget_min']?.toDouble(),
      budgetMax: data['budget_max']?.toDouble(),
      moveInDate: data['move_in_date'] != null 
          ? DateTime.parse(data['move_in_date'])
          : null,
      languages: data['languages'] != null 
          ? List<String>.from(data['languages'])
          : ['en'],
      isSmoker: data['is_smoker'],
      hasPets: data['has_pets'],
      noiseTolerance: data['noise_tolerance'],
      religion: data['religion'] != null 
          ? Religion.values.firstWhere(
              (e) => e.name == data['religion'],
              orElse: () => Religion.none,
            )
          : null,
      occupation: data['occupation'] != null 
          ? Occupation.values.firstWhere(
              (e) => e.name == data['occupation'],
              orElse: () => Occupation.other,
            )
          : null,
      studyField: data['study_field'],
      employer: data['employer'],
      isVerified: data['is_verified'] ?? false,
      isActive: data['is_active'] ?? true,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  // Convert to Supabase data
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_type': profileType?.name,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender?.name,
      'profile_photo_url': profilePhotoUrl,
      'current_location': currentLocation,
      'preferred_areas': preferredAreas,
      'budget_min': budgetMin,
      'budget_max': budgetMax,
      'move_in_date': moveInDate?.toIso8601String(),
      'languages': languages,
      'is_smoker': isSmoker,
      'has_pets': hasPets,
      'noise_tolerance': noiseTolerance,
      'religion': religion?.name,
      'occupation': occupation?.name,
      'study_field': studyField,
      'employer': employer,
      'is_verified': isVerified,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    ProfileType? profileType,
    DateTime? dateOfBirth,
    Gender? gender,
    String? profilePhotoUrl,
    String? currentLocation,
    String? preferredAreas,
    double? budgetMin,
    double? budgetMax,
    DateTime? moveInDate,
    List<String>? languages,
    bool? isSmoker,
    bool? hasPets,
    String? noiseTolerance,
    Religion? religion,
    Occupation? occupation,
    String? studyField,
    String? employer,
    bool? isVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileType: profileType ?? this.profileType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      currentLocation: currentLocation ?? this.currentLocation,
      preferredAreas: preferredAreas ?? this.preferredAreas,
      budgetMin: budgetMin ?? this.budgetMin,
      budgetMax: budgetMax ?? this.budgetMax,
      moveInDate: moveInDate ?? this.moveInDate,
      languages: languages ?? this.languages,
      isSmoker: isSmoker ?? this.isSmoker,
      hasPets: hasPets ?? this.hasPets,
      noiseTolerance: noiseTolerance ?? this.noiseTolerance,
      religion: religion ?? this.religion,
      occupation: occupation ?? this.occupation,
      studyField: studyField ?? this.studyField,
      employer: employer ?? this.employer,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 