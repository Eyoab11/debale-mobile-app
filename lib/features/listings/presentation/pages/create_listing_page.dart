import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateListingPage extends ConsumerStatefulWidget {
  const CreateListingPage({super.key});

  @override
  ConsumerState<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends ConsumerState<CreateListingPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _roomTitleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _availableFromController = TextEditingController();
  final _houseRulesController = TextEditingController();
  
  // Form data
  String _selectedRoomType = '';
  String _selectedPropertyType = '';
  List<String> _selectedAmenities = [];
  String _selectedGenderPreference = 'No preference';
  String _selectedAgeRange = 'Any age';
  String _selectedOccupation = 'No preference';
  bool _agreementChecked = false;

  final List<String> _roomTypes = [
    'Private Room',
    'Shared Room',
    'Master Bedroom',
    'Studio',
    'Bachelor',
  ];

  final List<String> _propertyTypes = [
    'Apartment',
    'House',
    'Villa',
    'Condominium',
    'Student Housing',
  ];

  final List<String> _amenities = [
    'WiFi',
    'Parking',
    'Kitchen Access',
    'Laundry',
    'Security',
    'Study Area',
    'Gym',
    'Balcony',
    'AC',
    'Furnished',
    'Private Bathroom',
    'Garden',
  ];

  final List<String> _genderPreferences = [
    'No preference',
    'Male only',
    'Female only',
  ];

  final List<String> _ageRanges = [
    'Any age',
    '18-25',
    '25-35',
    '35-50',
    '50+',
  ];

  final List<String> _occupations = [
    'No preference',
    'Student',
    'Professional',
    'Working',
    'Remote Worker',
  ];

  @override
  void dispose() {
    _roomTitleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _availableFromController.dispose();
    _houseRulesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          _buildHeader(),
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildCurrentStep(),
            ),
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
              const Text(
                'Back to Dashboard',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'List Your Room',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildProgressStep(1, 'Basic Info', _currentStep >= 0),
                    _buildProgressLine(_currentStep > 0),
                    _buildProgressStep(2, 'Details', _currentStep >= 1),
                    _buildProgressLine(_currentStep > 1),
                    _buildProgressStep(3, 'Photos', _currentStep >= 2),
                    _buildProgressLine(_currentStep > 2),
                    _buildProgressStep(4, 'Review', _currentStep >= 3),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Step ${_currentStep + 1} of 4',
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

  Widget _buildProgressStep(int step, String label, bool isCompleted) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFFF6CB5A) : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Color(0xFF222222), size: 20)
                : Text(
                    step.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isCompleted ? const Color(0xFFF6CB5A) : Colors.grey[600],
              fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine(bool isCompleted) {
    return Container(
      height: 2,
      color: isCompleted ? const Color(0xFFF6CB5A) : Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildDetailsStep();
      case 2:
        return _buildPhotosStep();
      case 3:
        return _buildReviewStep();
      default:
        return _buildBasicInfoStep();
    }
  }

  Widget _buildBasicInfoStep() {
    return Container(
      padding: const EdgeInsets.all(32),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tell us about your room and location.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                TextFormField(
                  controller: _roomTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Room Title*',
                    hintText: 'e.g., Cozy Room Near AAU Campus',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a room title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location*',
                          hintText: 'e.g., Sidist Kilo, Addis Ababa',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Monthly Rent (Birr)*',
                          hintText: 'e.g., 1500',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the rent amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedRoomType.isEmpty ? null : _selectedRoomType,
                        decoration: const InputDecoration(
                          labelText: 'Room Type*',
                          hintText: 'Select room type',
                          border: OutlineInputBorder(),
                        ),
                        items: _roomTypes.map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRoomType = value ?? '';
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a room type';
                          }
                          return null;
                        },
                        isExpanded: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedPropertyType.isEmpty ? null : _selectedPropertyType,
                        decoration: const InputDecoration(
                          labelText: 'Property Type',
                          hintText: 'Select property type',
                          border: OutlineInputBorder(),
                        ),
                        items: _propertyTypes.map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPropertyType = value ?? '';
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description*',
                    hintText: 'Describe your room, the house, neighborhood, and what makes it special...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: null, // Disabled on first step
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      'Previous',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6CB5A),
                      foregroundColor: const Color(0xFF222222),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Next Step'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsStep() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          const Text(
            'Details & Preferences',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Help us match you with the right roommate.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Amenities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _amenities.map((amenity) => FilterChip(
              label: Text(amenity),
              selected: _selectedAmenities.contains(amenity),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAmenities.add(amenity);
                  } else {
                    _selectedAmenities.remove(amenity);
                  }
                });
              },
              selectedColor: const Color(0xFFF6CB5A),
              checkmarkColor: const Color(0xFF222222),
            )).toList(),
          ),
          const SizedBox(height: 32),
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedGenderPreference,
                  decoration: const InputDecoration(
                    labelText: 'Gender Preference',
                    border: OutlineInputBorder(),
                  ),
                  items: _genderPreferences.map((pref) => DropdownMenuItem(
                    value: pref,
                    child: Text(
                      pref,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGenderPreference = value ?? 'No preference';
                    });
                  },
                  isExpanded: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedAgeRange,
                  decoration: const InputDecoration(
                    labelText: 'Preferred Age Range',
                    border: OutlineInputBorder(),
                  ),
                  items: _ageRanges.map((range) => DropdownMenuItem(
                    value: range,
                    child: Text(
                      range,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAgeRange = value ?? 'Any age';
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedOccupation,
                  decoration: const InputDecoration(
                    labelText: 'Preferred Occupation',
                    border: OutlineInputBorder(),
                  ),
                  items: _occupations.map((occ) => DropdownMenuItem(
                    value: occ,
                    child: Text(
                      occ,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOccupation = value ?? 'No preference';
                    });
                  },
                  isExpanded: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _availableFromController,
                  decoration: const InputDecoration(
                    labelText: 'Available From',
                    hintText: 'mm/dd/yyyy',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'House Rules',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _houseRulesController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'House Rules',
              hintText: 'e.g., No smoking, Quiet hours 10 PM - 7 AM, Clean common areas...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFF6CB5A)),
                  ),
                  child: const Text('Previous'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6CB5A),
                    foregroundColor: const Color(0xFF222222),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Next Step'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosStep() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          const Text(
            'Add Photos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Great photos help your listing stand out.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF6CB5A),
                style: BorderStyle.solid,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.camera_alt,
                  size: 48,
                  color: Color(0xFFF6CB5A),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Upload Room Photos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add at least 3 photos of your room and common areas',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement photo upload
                  },
                  icon: const Icon(Icons.upload, color: Color(0xFF222222)),
                  label: const Text(
                    'Choose Photos',
                    style: TextStyle(color: Color(0xFF222222)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6CB5A),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: List.generate(3, (index) => Container(
              width: 100,
              height: 80,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            )),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Photo Tips:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Take photos during the day with good natural lighting\n'
                  '• Include photos of the room, common areas, and exterior\n'
                  '• Make sure the space is clean and tidy\n'
                  '• Show unique features and amenities',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFF6CB5A)),
                  ),
                  child: const Text('Previous'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6CB5A),
                    foregroundColor: const Color(0xFF222222),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Next Step'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          const Text(
            'Review Your Listing',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Make sure everything looks good before publishing.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF6CB5A)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _roomTitleController.text.isEmpty ? 'Room Title' : _roomTitleController.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFF6CB5A), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      _locationController.text.isEmpty ? 'Location' : _locationController.text,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    if (_selectedRoomType.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6CB5A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _selectedRoomType,
                          style: const TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _descriptionController.text.isEmpty 
                      ? 'Room description will appear here...' 
                      : _descriptionController.text,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_priceController.text.isEmpty ? '0' : _priceController.text} Birr per month',
                      style: const TextStyle(
                        color: Color(0xFFF6CB5A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(3, (index) => Container(
                    width: 80,
                    height: 60,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: Colors.grey),
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(
                value: _agreementChecked,
                onChanged: (value) {
                  setState(() {
                    _agreementChecked = value ?? false;
                  });
                },
                activeColor: const Color(0xFFF6CB5A),
              ),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(text: 'I agree to DebalE\'s '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Color(0xFFF6CB5A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' and confirm that all information provided is accurate. I understand that false information may result in account suspension.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFF6CB5A)),
                  ),
                  child: const Text('Previous'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _agreementChecked ? _publishListing : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Publish Listing'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _publishListing() {
    // TODO: Implement listing publishing logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Room listing published successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }
} 