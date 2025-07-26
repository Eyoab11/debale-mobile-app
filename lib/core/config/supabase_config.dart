class SupabaseConfig {
  // TODO: Replace with your actual Supabase credentials
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // Table names
  static const String profilesTable = 'profiles';
  static const String listingsTable = 'listings';
  static const String listingPhotosTable = 'listing_photos';
  static const String matchesTable = 'matches';
  static const String messagesTable = 'messages';
  static const String notificationsTable = 'notifications';
  static const String paymentsTable = 'payments';
  static const String subscriptionsTable = 'subscriptions';
  static const String seekerPostsTable = 'seeker_posts';
  
  // Storage bucket names
  static const String listingPhotosBucket = 'listing-photos';
  static const String profilePhotosBucket = 'profile-photos';
  
  // Real-time channels
  static const String messagesChannel = 'messages';
  static const String notificationsChannel = 'notifications';
  static const String matchesChannel = 'matches';
  
  // RPC function names
  static const String calculateCompatibilityFunction = 'calculate_compatibility';
  static const String searchListingsFunction = 'search_listings';
  static const String getMatchesFunction = 'get_matches';
} 