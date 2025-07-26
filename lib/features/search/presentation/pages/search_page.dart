import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:debale/features/search/presentation/pages/room_details_page.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedPriceRange = 'Any';
  String _selectedRoomType = 'Any';
  String _selectedGender = 'Any';
  bool _showAdvancedFilters = false;

  final List<Map<String, dynamic>> _mockRooms = [
    {
      'id': '1',
      'title': 'Cozy Studio Near AAU',
      'location': 'Bole, Addis Ababa',
      'price': 8000,
      'roomType': 'Studio',
      'gender': 'Female',
      'availableFrom': '2024-01-15',
      'imageUrl': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300&h=200&fit=crop',
      'amenities': ['WiFi', 'Kitchen', 'Bathroom'],
      'description': 'Beautiful studio apartment with modern amenities, perfect for students.',
      'rating': 4.5,
      'reviews': 12,
    },
    {
      'id': '2',
      'title': 'Shared Room in Student House',
      'location': 'Kazanchis, Addis Ababa',
      'price': 4500,
      'roomType': 'Shared',
      'gender': 'Male',
      'availableFrom': '2024-01-20',
      'imageUrl': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300&h=200&fit=crop',
      'amenities': ['WiFi', 'Kitchen', 'Laundry', 'Study Area'],
      'description': 'Friendly student house with shared facilities and study areas.',
      'rating': 4.2,
      'reviews': 8,
    },
    {
      'id': '3',
      'title': 'Private Room with Balcony',
      'location': 'Saris, Addis Ababa',
      'price': 12000,
      'roomType': 'Private',
      'gender': 'Any',
      'availableFrom': '2024-02-01',
      'imageUrl': 'https://images.unsplash.com/photo-1560448075-bb485b067938?w=300&h=200&fit=crop',
      'amenities': ['WiFi', 'Kitchen', 'Bathroom', 'Balcony', 'Parking'],
      'description': 'Spacious private room with beautiful balcony view and parking.',
      'rating': 4.8,
      'reviews': 15,
    },
    {
      'id': '4',
      'title': 'Budget-Friendly Student Room',
      'location': 'Megenagna, Addis Ababa',
      'price': 3500,
      'roomType': 'Private',
      'gender': 'Female',
      'availableFrom': '2024-01-10',
      'imageUrl': 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=300&h=200&fit=crop',
      'amenities': ['WiFi', 'Kitchen'],
      'description': 'Affordable room perfect for students on a budget.',
      'rating': 4.0,
      'reviews': 6,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildSearchSection(),
          _buildResultsHeader(),
          _buildRoomGrid(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFFF6CB5A),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Find Your Room',
          style: TextStyle(
            color: Color(0xFF222222),
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF6CB5A), Color(0xFFF4A261)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search rooms, locations, or keywords...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFFF6CB5A)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Filter and Search Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                setState(() {
                        _showAdvancedFilters = !_showAdvancedFilters;
                });
              },
                    icon: const Icon(Icons.filter_list, color: Color(0xFFF6CB5A)),
                    label: const Text('Filters', style: TextStyle(color: Color(0xFFF6CB5A))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFF6CB5A)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement search
                    },
                    icon: const Icon(Icons.search, color: Color(0xFF222222)),
                    label: const Text('Search', style: TextStyle(color: Color(0xFF222222))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6CB5A),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            
            // Advanced Filters
            if (_showAdvancedFilters) ...[
              const SizedBox(height: 16),
              _buildAdvancedFilters(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Advanced Filters',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          
          // Location
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter city or area',
              prefixIcon: Icon(Icons.location_on, color: Color(0xFFF6CB5A)),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          
          // Price Range
          DropdownButtonFormField<String>(
            value: _selectedPriceRange,
            decoration: const InputDecoration(
              labelText: 'Price Range',
              prefixIcon: Icon(Icons.attach_money, color: Color(0xFFF6CB5A)),
              border: OutlineInputBorder(),
            ),
            items: ['Any', 'Under 5,000', '5,000 - 10,000', '10,000 - 15,000', 'Over 15,000']
                .map((range) => DropdownMenuItem(value: range, child: Text(range)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedPriceRange = value!;
              });
            },
          ),
          const SizedBox(height: 12),
          
          // Room Type
          DropdownButtonFormField<String>(
            value: _selectedRoomType,
            decoration: const InputDecoration(
              labelText: 'Room Type',
              prefixIcon: Icon(Icons.bed, color: Color(0xFFF6CB5A)),
              border: OutlineInputBorder(),
            ),
            items: ['Any', 'Private', 'Shared', 'Studio']
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedRoomType = value!;
              });
            },
          ),
          const SizedBox(height: 12),
          
          // Gender Preference
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: 'Gender Preference',
              prefixIcon: Icon(Icons.person, color: Color(0xFFF6CB5A)),
              border: OutlineInputBorder(),
            ),
            items: ['Any', 'Male', 'Female']
                .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_mockRooms.length} rooms found',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            DropdownButton<String>(
              value: 'Relevance',
              items: ['Relevance', 'Price: Low to High', 'Price: High to Low', 'Rating']
                  .map((sort) => DropdownMenuItem(value: sort, child: Text(sort)))
                  .toList(),
              onChanged: (value) {
                // TODO: Implement sorting
              },
              underline: Container(),
              icon: const Icon(Icons.sort, color: Color(0xFFF6CB5A)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildRoomCard(_mockRooms[index]),
          childCount: _mockRooms.length,
        ),
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailsPage(room: room),
          ),
        );
      },
      child: Container(
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
            // Image section
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  room['imageUrl'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6CB5A),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.home,
                          size: 40,
                          color: Color(0xFF222222),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Content section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      room['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            room['location'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Price
                    Text(
                      'ETB ${room['price'].toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF6CB5A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Room details
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6CB5A).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            room['roomType'],
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6CB5A).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            room['gender'],
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFF6CB5A), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${room['rating']} (${room['reviews']})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 