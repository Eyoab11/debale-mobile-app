import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:debale/features/auth/presentation/pages/login_page.dart';
import 'package:debale/features/auth/presentation/pages/register_page.dart';
import 'package:debale/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:debale/features/home/presentation/pages/home_page.dart';
import 'package:debale/features/profile/presentation/pages/profile_page.dart';
import 'package:debale/features/search/presentation/pages/search_page.dart';
import 'package:debale/features/messages/presentation/pages/messages_page.dart';
import 'package:debale/features/listings/presentation/pages/listing_details_page.dart';
import 'package:debale/features/listings/presentation/pages/create_listing_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      
      // Authentication
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/messages',
        builder: (context, state) => const MessagesPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      
      // Listing Routes
      GoRoute(
        path: '/listing/:id',
        builder: (context, state) {
          final listingId = state.pathParameters['id']!;
          return ListingDetailsPage(listingId: listingId);
        },
      ),
      GoRoute(
        path: '/create-listing',
        builder: (context, state) => const CreateListingPage(),
      ),
    ],
  );
}); 