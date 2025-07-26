import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationState {
  final Position? currentPosition;
  final String? currentAddress;
  final bool isLoading;
  final String? error;
  final bool hasPermission;

  const LocationState({
    this.currentPosition,
    this.currentAddress,
    this.isLoading = false,
    this.error,
    this.hasPermission = false,
  });

  LocationState copyWith({
    Position? currentPosition,
    String? currentAddress,
    bool? isLoading,
    String? error,
    bool? hasPermission,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      currentAddress: currentAddress ?? this.currentAddress,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasPermission: hasPermission ?? this.hasPermission,
    );
  }
}

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(const LocationState());

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
            isLoading: false,
            error: 'Location permission denied',
            hasPermission: false,
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location permissions are permanently denied',
          hasPermission: false,
        );
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      state = state.copyWith(
        currentPosition: position,
        isLoading: false,
        hasPermission: true,
      );

      // Get address from coordinates
      await getAddressFromCoordinates(position);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getAddressFromCoordinates(Position position) async {
    try {
      // TODO: Implement geocoding to get address from coordinates
      // For now, just use coordinates as address
      final address = '${position.latitude}, ${position.longitude}';
      
      state = state.copyWith(currentAddress: address);
    } catch (e) {
      // Don't update state on error, just log it
      print('Error getting address: $e');
    }
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});

// Convenience providers
final currentPositionProvider = Provider<Position?>((ref) {
  return ref.watch(locationProvider).currentPosition;
});

final currentAddressProvider = Provider<String?>((ref) {
  return ref.watch(locationProvider).currentAddress;
}); 