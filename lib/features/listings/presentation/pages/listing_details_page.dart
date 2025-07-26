import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListingDetailsPage extends ConsumerStatefulWidget {
  final String listingId;

  const ListingDetailsPage({
    super.key,
    required this.listingId,
  });

  @override
  ConsumerState<ListingDetailsPage> createState() => _ListingDetailsPageState();
}

class _ListingDetailsPageState extends ConsumerState<ListingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfo(),
                  const SizedBox(height: 24),
                  _buildPhotos(),
                  const SizedBox(height: 24),
                  _buildDescription(),
                  const SizedBox(height: 24),
                  _buildAmenities(),
                  const SizedBox(height: 24),
                  _buildLocation(),
                  const SizedBox(height: 24),
                  _buildProviderInfo(),
                  const SizedBox(height: 24),
                  _buildHouseRules(),
                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomActions(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: PageView.builder(
          itemCount: 5, // Mock photos
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            // TODO: Add to favorites
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // TODO: Share listing
          },
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Cozy Private Room in Bole',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'AVAILABLE',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Bole, Addis Ababa',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              '5,000 Birr',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.green[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '/month',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Deposit: 10,000 Birr',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Beautiful private room in a shared apartment located in the heart of Bole. '
          'The room comes with a comfortable bed, study desk, and wardrobe. '
          'Shared kitchen and bathroom with modern amenities. '
          'Perfect for students or young professionals. '
          'Walking distance to restaurants, shops, and public transportation.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenities() {
    final amenities = [
      {'icon': Icons.wifi, 'name': 'WiFi'},
      {'icon': Icons.kitchen, 'name': 'Kitchen'},
      {'icon': Icons.local_laundry_service, 'name': 'Laundry'},
      {'icon': Icons.local_parking, 'name': 'Parking'},
      {'icon': Icons.security, 'name': 'Security'},
      {'icon': Icons.ac_unit, 'name': 'AC'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: amenities.length,
          itemBuilder: (context, index) {
            final amenity = amenities[index];
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    amenity['icon'] as IconData,
                    color: Colors.green[600],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    amenity['name'] as String,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.green[600],
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Bole, Addis Ababa, Ethiopia',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.map,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProviderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Listed by',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person),
            ),
            title: const Text('Abebe Kebede'),
            subtitle: const Text('Verified Provider'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                const Text('4.8'),
              ],
            ),
            onTap: () {
              // TODO: Navigate to provider profile
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHouseRules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'House Rules',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRuleItem('No smoking', Icons.smoke_free),
                _buildRuleItem('No pets', Icons.pets),
                _buildRuleItem('Quiet hours: 10 PM - 7 AM', Icons.volume_off),
                _buildRuleItem('Keep common areas clean', Icons.cleaning_services),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRuleItem(String rule, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(child: Text(rule)),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Contact provider
              },
              icon: const Icon(Icons.message),
              label: const Text('Message'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Schedule viewing
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text('Schedule Viewing'),
            ),
          ),
        ],
      ),
    );
  }
} 