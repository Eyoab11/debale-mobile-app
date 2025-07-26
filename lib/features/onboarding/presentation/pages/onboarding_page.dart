import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      title: 'Find Your Perfect Roommate',
      description: 'Connect with trusted roommates and find affordable housing in Ethiopia',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingStep(
      title: 'Smart Matching',
      description: 'Our algorithm matches you with compatible roommates based on lifestyle and preferences',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingStep(
      title: 'Safe & Secure',
      description: 'Verified profiles and secure messaging ensure your safety',
      image: 'assets/images/onboarding_3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return _buildStep(_steps[index]);
                },
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(OnboardingStep step) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              step.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            step.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            step.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _steps.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < _steps.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  context.go('/');
                }
              },
              child: Text(
                _currentPage < _steps.length - 1 ? 'Next' : 'Get Started',
              ),
            ),
          ),
          if (_currentPage < _steps.length - 1) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Skip'),
            ),
          ],
        ],
      ),
    );
  }
}

class OnboardingStep {
  final String title;
  final String description;
  final String image;

  OnboardingStep({
    required this.title,
    required this.description,
    required this.image,
  });
} 