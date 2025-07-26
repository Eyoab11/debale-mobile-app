import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:debale/features/search/presentation/pages/search_page.dart';
import 'package:debale/features/messages/presentation/pages/messages_page.dart';
import 'package:debale/features/profile/presentation/pages/profile_page.dart';
import 'package:debale/features/listings/presentation/pages/create_listing_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContentPage(),
    const SearchPage(),
    const MessagesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateListingPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeContentPage extends ConsumerWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildTestimonialsSection(),
            _buildHowItWorksSection(),
            _buildWhyChooseSection(),
            _buildCallToActionSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF6CB5A), Color(0xFFF4A261)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.coffee,
                size: 32,
                color: Color(0xFF222222),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.notifications, color: Color(0xFF222222)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notifications coming soon!')),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'DebalE',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Connecting Ethiopian students and young professionals with safe, affordable housing solutions',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF222222),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'What Our Users Say',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTestimonialCard(
                  rating: 5,
                  quote: "Found my perfect roommate through DebalE! The verification system gave me peace of mind.",
                  name: "Abebe Kebede",
                  role: "AAU Student",
                  imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop",
                ),
                _buildTestimonialCard(
                  rating: 5,
                  quote: "Affordable and safe housing options. The local expertise really makes a difference.",
                  name: "Sara Haile",
                  role: "Software Developer",
                  imageUrl: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400&h=300&fit=crop",
                ),
                _buildTestimonialCard(
                  rating: 5,
                  quote: "As a room provider, I feel confident knowing all users are verified. Great platform!",
                  name: "Mulugeta Desta",
                  role: "Room Provider",
                  imageUrl: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=300&fit=crop",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required int rating,
    required String quote,
    required String name,
    required String role,
    required String imageUrl,
  }) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Row(
            children: List.generate(5, (index) => const Icon(
              Icons.star,
              color: Color(0xFFF6CB5A),
              size: 20,
            )),
          ),
          const SizedBox(height: 12),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF222222),
              height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person, color: Colors.grey),
                    );
                },
              ),
            ),
              const SizedBox(width: 12),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                    Text(
                      role,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
              ),
            ),
          ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'How DebalE Works',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Simple, safe, and effective way to find your ideal living situation',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Desktop layout
                return Row(
                  children: [
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.person_add,
                      title: 'Create Profile',
                      description: 'Tell us about yourself, your preferences, and what you\'re looking for in a roommate or room.',
                      imageUrl: "https://images.unsplash.com/photo-1551434678-e076c223a692?w=300&h=200&fit=crop",
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.search,
                      title: 'Smart Matching',
                      description: 'Our algorithm finds compatible matches based on location, budget, lifestyle, and preferences.',
                      imageUrl: "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=300&h=200&fit=crop",
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.chat_bubble,
                      title: 'Connect Safely',
                      description: 'Chat securely, meet in safe locations, and move in with confidence using our verification system.',
                      imageUrl: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=300&h=200&fit=crop",
                    )),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.person_add,
                      title: 'Create Profile',
                      description: 'Tell us about yourself, your preferences, and what you\'re looking for in a roommate or room.',
                      imageUrl: "https://images.unsplash.com/photo-1551434678-e076c223a692?w=300&h=200&fit=crop",
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.search,
                      title: 'Smart Matching',
                      description: 'Our algorithm finds compatible matches based on location, budget, lifestyle, and preferences.',
                      imageUrl: "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=300&h=200&fit=crop",
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.chat_bubble,
                      title: 'Connect Safely',
                      description: 'Chat securely, meet in safe locations, and move in with confidence using our verification system.',
                      imageUrl: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=300&h=200&fit=crop",
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Container(
          padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
          child: Column(
            children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6CB5A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF222222),
                    size: 40,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFF6CB5A),
              shape: BoxShape.circle,
            ),
            child: Icon(
                icon,
              color: const Color(0xFF222222),
              size: 30,
            ),
              ),
          const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
              fontSize: 16,
                  fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
                ),
            textAlign: TextAlign.center,
              ),
          const SizedBox(height: 8),
              Text(
            description,
            style: const TextStyle(
                  fontSize: 12,
              color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
    );
  }

  Widget _buildWhyChooseSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Why Choose DebalE?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Built specifically for the Ethiopian market',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Desktop layout
                return Row(
                  children: [
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.verified_user,
                      title: 'Verified Profiles',
                      description: 'All users are verified with phone numbers, student IDs, or employment letters for your safety.',
                      imageUrl: "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=300&h=200&fit=crop",
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.location_on,
                      title: 'Local Expertise',
                      description: 'Deep understanding of Ethiopian cities, universities, and cultural preferences.',
                      imageUrl: "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=300&h=200&fit=crop",
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.people,
                      title: 'Cultural Matching',
                      description: 'Find roommates who share your cultural values, language preferences, and lifestyle.',
                      imageUrl: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=300&h=200&fit=crop",
                    )),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.verified_user,
                      title: 'Verified Profiles',
                      description: 'All users are verified with phone numbers, student IDs, or employment letters for your safety.',
                      imageUrl: "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=300&h=200&fit=crop",
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.location_on,
                      title: 'Local Expertise',
                      description: 'Deep understanding of Ethiopian cities, universities, and cultural preferences.',
                      imageUrl: "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=300&h=200&fit=crop",
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.people,
                      title: 'Cultural Matching',
                      description: 'Find roommates who share your cultural values, language preferences, and lifestyle.',
                      imageUrl: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=300&h=200&fit=crop",
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionSection() {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6CB5A), Color(0xFFF4A261)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Ready to Find Your Perfect Match?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Join thousands of Ethiopian students and professionals who found their ideal living situation',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF222222),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (layoutContext, constraints) {
                if (constraints.maxWidth > 400) {
                  return Row(
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222222),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Get Started Free'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Builder(
                          builder: (context) => OutlinedButton(
                            onPressed: () {
                              context.go('/search');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF222222),
                              side: const BorderSide(color: Color(0xFF222222)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Browse Rooms'),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                          children: [
                      Builder(
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222222),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Get Started Free'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Builder(
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              context.go('/search');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF222222),
                              side: const BorderSide(color: Color(0xFF222222)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Browse Rooms'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        color: const Color(0xFF222222),
        child: Column(
          children: [
            Row(
      children: [
                const Icon(
                  Icons.coffee,
                  color: Color(0xFFF6CB5A),
                  size: 24,
                ),
                const SizedBox(width: 8),
        const Text(
                  'DebalE',
          style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Connecting Ethiopian students and young professionals with safe, affordable housing solutions',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (layoutContext, constraints) {
                if (constraints.maxWidth > 400) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFooterLink('Room Seekers'),
                      _buildFooterLink('Room Providers'),
                      _buildFooterLink('Support'),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildFooterLink('Room Seekers'),
                      const SizedBox(height: 8),
                      _buildFooterLink('Room Providers'),
                      const SizedBox(height: 8),
                      _buildFooterLink('Support'),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Made with ❤️ for Ethiopia',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Builder(
      builder: (context) => TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(' $text page coming soon!')),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
} 