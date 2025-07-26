import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:debale/core/providers/auth_provider.dart';
import 'package:debale/features/auth/domain/entities/user.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(user),
            const SizedBox(height: 24),
            _buildProfileStats(),
            const SizedBox(height: 24),
            _buildProfileActions(),
            const SizedBox(height: 24),
            _buildProfileSections(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User? user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: user?.profilePhotoUrl != null
                  ? ClipOval(
                      child: Image.network(
                        user!.profilePhotoUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'User Name',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'user@example.com',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user?.profileType?.name.toUpperCase() ?? 'SEEKER',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Edit profile
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Share profile
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Listings',
            value: '3',
            icon: Icons.home,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            title: 'Matches',
            value: '12',
            icon: Icons.favorite,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            title: 'Reviews',
            value: '4.8',
            icon: Icons.star,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.green[600],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.add,
                title: 'Create Listing',
                onTap: () {
                  // TODO: Navigate to create listing
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                icon: Icons.verified_user,
                title: 'Verify Profile',
                onTap: () {
                  // TODO: Navigate to verification
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildProfileSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _buildProfileSectionItem(
                icon: Icons.person,
                title: 'Personal Information',
                subtitle: 'Edit your basic details',
                onTap: () {
                  // TODO: Navigate to personal info
                },
              ),
              _buildProfileSectionItem(
                icon: Icons.location_on,
                title: 'Location & Preferences',
                subtitle: 'Update your location and preferences',
                onTap: () {
                  // TODO: Navigate to location preferences
                },
              ),
              _buildProfileSectionItem(
                icon: Icons.security,
                title: 'Privacy & Security',
                subtitle: 'Manage your privacy settings',
                onTap: () {
                  // TODO: Navigate to privacy settings
                },
              ),
              _buildProfileSectionItem(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Configure notification preferences',
                onTap: () {
                  // TODO: Navigate to notifications
                },
              ),
              _buildProfileSectionItem(
                icon: Icons.help,
                title: 'Help & Support',
                subtitle: 'Get help and contact support',
                onTap: () {
                  // TODO: Navigate to help
                },
              ),
              _buildProfileSectionItem(
                icon: Icons.logout,
                title: 'Sign Out',
                subtitle: 'Sign out of your account',
                onTap: () {
                  _showSignOutDialog(context);
                },
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSectionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement sign out
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
} 