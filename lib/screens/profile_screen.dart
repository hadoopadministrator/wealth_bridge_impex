import 'package:flutter/material.dart';
import 'package:wealth_bridge_impex/services/api_service.dart';
import 'package:wealth_bridge_impex/widgets/info_row.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final ApiService _apiService = ApiService();
  bool isEditing = false;

  // Controllers (API fields)
  final TextEditingController fullNameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'john@example.com',
  );
  final TextEditingController mobileController = TextEditingController(
    text: '9876543210',
  );
  final TextEditingController addressController = TextEditingController(
    text: 'Main Road, Mumbai',
  );
  final TextEditingController landmarkController = TextEditingController(
    text: 'Near City Mall',
  );
  final TextEditingController pincodeController = TextEditingController(
    text: '400001',
  );
  final TextEditingController gstController = TextEditingController(
    text: '27ABCDE1234F1Z5',
  );
  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    pincodeController.dispose();
    gstController.dispose();
    super.dispose();
  }

  void updateProfile() {
    // Call Update Profile API here
    // id, fullname, email, mobile, address, landmark, pincode, gst

    setState(() {
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      isDense: true,
    );
  }

  Widget _buildField({
    required IconData icon,
    required String label,
    required String value,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    if (isEditing) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: _inputDecoration(label),
        ),
      );
    }

    return Column(
      children: [
        InfoRow(icon: icon, label: label, value: value),
        const Divider(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            // icon: Icon(isEditing ? Icons.close : Icons.edit),
            icon: Icon(Icons.edit),
            onPressed: ()   {
               print('updating profile:');
               final apiService = ApiService();
               apiService.updateUserProfile(
                id: 32,
                fullname: 'AlexBen',
                email: 'alex@gmail.com',
                mobile: '7788445522',
                address: 'address',
                landmark: 'landmark',
                pincode: '123456',
                gst: '1234567890',
              );
              // setState(() {
              //   isEditing = !isEditing;
              // });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.amber.shade100,
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: const Color(0xffF9B236),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      fullNameController.text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildField(
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      value: fullNameController.text,
                      controller: fullNameController,
                    ),
                    _buildField(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: emailController.text,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildField(
                      icon: Icons.phone_outlined,
                      label: 'Mobile',
                      value: mobileController.text,
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildField(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      value: addressController.text,
                      controller: addressController,
                    ),
                    _buildField(
                      icon: Icons.place_outlined,
                      label: 'Landmark',
                      value: landmarkController.text,
                      controller: landmarkController,
                    ),
                    _buildField(
                      icon: Icons.pin_drop_outlined,
                      label: 'Pincode',
                      value: pincodeController.text,
                      controller: pincodeController,
                      keyboardType: TextInputType.number,
                    ),
                    _buildField(
                      icon: Icons.receipt_long_outlined,
                      label: 'GST Number',
                      value: gstController.text,
                      controller: gstController,
                    ),
                    if (isEditing) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF9B236),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Future<void> onSaveProfile() async {
//   try {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );

//     final result = await _apiService.updateUserProfile(
//       id: 32,
//       fullname: fullNameController.text,
//       email: emailController.text,
//       mobile: mobileController.text,
//       address: addressController.text,
//       landmark: landmarkController.text,
//       pincode: pincodeController.text,
//       gst: gstController.text,
//     );

//     if (!mounted) return;
//     Navigator.pop(context);

//     if (result['Status'] == 'Success') {
//       setState(() => isEditing = false);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['Message'])),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['Message'])),
//       );
//     }
//   } catch (e) {
//     if (!mounted) return;
//     Navigator.pop(context);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Unexpected error occurred')),
//     );
//   }
// }
}
