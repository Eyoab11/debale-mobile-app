import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debale/features/auth/domain/entities/user.dart';

// Auth State
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // TODO: Implement actual authentication logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Mock user for now
      final user = User(
        id: '1',
        email: 'test@example.com',
        fullName: 'Test User',
        phoneNumber: '+251912345678',
        profileType: ProfileType.seeker,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signUp(String email, String password, String fullName, String phoneNumber, ProfileType profileType) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // TODO: Implement actual registration logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      final user = User(
        id: '1',
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        profileType: profileType,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // TODO: Implement actual sign out logic
      await Future.delayed(const Duration(seconds: 1));
      
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // TODO: Check if user is already authenticated
      await Future.delayed(const Duration(seconds: 1));
      
      // For now, assume not authenticated
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Convenience providers
final userProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
}); 