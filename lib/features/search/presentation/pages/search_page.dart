import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  String _selectedSortBy = 'Relevance';
  bool _showFilters = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildResultsHeader(),
          Expanded(
            child: _buildJobListings(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF222222)),
                onPressed: () => Navigator.pop(context),
              ),
              const Icon(
                Icons.coffee,
                color: Color(0xFFF6CB5A),
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'DebalE',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // TODO: Navigate to dashboard
                },
                child: const Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to messages
                },
                child: const Text(
                  'Messages',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find Your Perfect Job',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Discover opportunities that match your skills and career goals',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by job title, company, or location...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFF6CB5A)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFF6CB5A), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _showFilters = !_showFilters;
                  });
                },
                icon: const Icon(Icons.filter_list, color: Color(0xFF222222)),
                label: const Text(
                  'Filters',
                  style: TextStyle(color: Color(0xFF222222)),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF6CB5A),
                  side: const BorderSide(color: Color(0xFFF6CB5A)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Perform search
                },
                icon: const Icon(Icons.search, color: Color(0xFF222222)),
                label: const Text(
                  'Search',
                  style: TextStyle(color: Color(0xFF222222)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF6CB5A),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
          if (_showFilters) ...[
            const SizedBox(height: 16),
            _buildFilterOptions(),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Options',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'All Job Types',
                  decoration: const InputDecoration(
                    labelText: 'Job Type',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All Job Types', 'Full-time', 'Part-time', 'Contract', 'Internship', 'Remote']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    // TODO: Handle job type filter
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'All Experience Levels',
                  decoration: const InputDecoration(
                    labelText: 'Experience Level',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All Experience Levels', 'Entry Level', 'Junior', 'Mid-level', 'Senior', 'Lead']
                      .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                      .toList(),
                  onChanged: (value) {
                    // TODO: Handle experience level filter
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'Any Salary',
                  decoration: const InputDecoration(
                    labelText: 'Salary Range',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Any Salary', '0-10,000 Birr', '10,000-25,000 Birr', '25,000-50,000 Birr', '50,000+ Birr']
                      .map((range) => DropdownMenuItem(value: range, child: Text(range)))
                      .toList(),
                  onChanged: (value) {
                    // TODO: Handle salary filter
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Jobs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '12 jobs found in Addis Ababa',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Sort by: ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              DropdownButton<String>(
                value: _selectedSortBy,
                underline: Container(),
                items: ['Relevance', 'Salary: High to Low', 'Salary: Low to High', 'Date Posted', 'Experience Level']
                    .map((sort) => DropdownMenuItem(value: sort, child: Text(sort)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSortBy = value!;
                  });
                },
                style: const TextStyle(
                  color: Color(0xFFF6CB5A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobListings() {
    // Mock job data
    final jobs = [
      {
        'title': 'Senior Flutter Developer',
        'company': 'TechCorp Ethiopia',
        'location': 'Bole, Addis Ababa',
        'salary': '45,000',
        'type': 'Full-time',
        'experience': '3-5 years',
        'rating': 4.8,
        'reviews': 12,
        'isFeatured': true,
        'isVerified': true,
        'skills': ['Flutter', 'Dart', 'Firebase'],
        'benefits': ['Health Insurance', 'Remote Work', 'Flexible Hours'],
      },
      {
        'title': 'Frontend Developer',
        'company': 'Digital Solutions Ltd',
        'location': 'Kirkos, Addis Ababa',
        'salary': '35,000',
        'type': 'Full-time',
        'experience': '1-3 years',
        'rating': 4.5,
        'reviews': 8,
        'isFeatured': false,
        'isVerified': true,
        'skills': ['React', 'JavaScript', 'CSS'],
        'benefits': ['Health Insurance', 'Professional Development'],
      },
      {
        'title': 'Backend Engineer',
        'company': 'Innovation Hub',
        'location': 'Yeka, Addis Ababa',
        'salary': '50,000',
        'type': 'Contract',
        'experience': '5-8 years',
        'rating': 4.9,
        'reviews': 15,
        'isFeatured': true,
        'isVerified': true,
        'skills': ['Node.js', 'Python', 'MongoDB'],
        'benefits': ['Health Insurance', 'Retirement Plan', 'Gym Membership'],
      },
      {
        'title': 'UI/UX Designer',
        'company': 'Creative Studio',
        'location': 'Kazanchis, Addis Ababa',
        'salary': '30,000',
        'type': 'Part-time',
        'experience': '2-4 years',
        'rating': 4.6,
        'reviews': 6,
        'isFeatured': false,
        'isVerified': false,
        'skills': ['Figma', 'Adobe XD', 'Prototyping'],
        'benefits': ['Flexible Hours', 'Remote Work'],
      },
      {
        'title': 'DevOps Engineer',
        'company': 'CloudTech Solutions',
        'location': 'Meskel Square, Addis Ababa',
        'salary': '55,000',
        'type': 'Full-time',
        'experience': '4-6 years',
        'rating': 4.7,
        'reviews': 10,
        'isFeatured': false,
        'isVerified': true,
        'skills': ['AWS', 'Docker', 'Kubernetes'],
        'benefits': ['Health Insurance', 'Transportation Allowance'],
      },
      {
        'title': 'Mobile App Developer',
        'company': 'AppWorks Ethiopia',
        'location': 'Sidist Kilo, Addis Ababa',
        'salary': '40,000',
        'type': 'Full-time',
        'experience': '2-4 years',
        'rating': 4.4,
        'reviews': 7,
        'isFeatured': false,
        'isVerified': true,
        'skills': ['React Native', 'iOS', 'Android'],
        'benefits': ['Health Insurance', 'Meal Allowance'],
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return _buildJobCard(job);
      },
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Container(
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
          // Image section with tags
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6CB5A),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(
                  child: Icon(
                    Icons.work,
                    size: 40,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
              if (job['isFeatured'])
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6CB5A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Featured',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (job['isVerified'])
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        const Text(
                          'Verified',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Color(0xFF222222)),
                  onPressed: () {
                    // TODO: Add to favorites
                  },
                ),
              ),
            ],
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${job['salary']} Birr',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF6CB5A),
                  ),
                ),
                const Text(
                  'per month',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFF6CB5A), size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        job['location'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.work, color: Color(0xFFF6CB5A), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      job['type'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.person, color: Color(0xFFF6CB5A), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      job['experience'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFF6CB5A), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${job['rating']} (${job['reviews']} reviews)',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: (job['skills'] as List<dynamic>).take(3).map<Widget>((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6CB5A).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      skill.toString(),
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: View job details
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF6CB5A),
                          foregroundColor: const Color(0xFF222222),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Contact employer
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFF6CB5A),
                          side: const BorderSide(color: Color(0xFFF6CB5A)),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 