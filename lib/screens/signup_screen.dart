import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
// Note: To use the 'Inter' font, you would need to add the
// google_fonts package to your pubspec.yaml file:
// dependencies:
//   google_fonts: ^6.1.0
//
// Then, uncomment the following line:
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HCC Sign Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // Uncomment this line to use the Inter font:
        // textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        // This sets the base background color for the app
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        // This sets the background for elements like cards, dialogs
        canvasColor: Colors.white,
      ),
      home: const SignUpScreen(),
    );
  }
}

// 1. Converted to StatefulWidget
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// 2. Created State class to hold logic
class _SignUpScreenState extends State<SignUpScreen> {
  // 3. Added all controllers from your logic + UI fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // Added for logic
  final _mobileController = TextEditingController(); // Added from UI
  final _roomController = TextEditingController(); // Added from UI

  bool _loading = false;

  // 4. Added your registerUser function
  Future<void> registerUser() async {
    // Check for mounted widget before showing SnackBar
    if (!mounted) return;
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match ❌')),
      );
      return;
    }

    // Check if all fields are filled (basic validation)
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _roomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 5. Updated Firestore document to include ALL fields
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'mobileNumber': _mobileController.text.trim(), // Added
        'roomNumber': _roomController.text.trim(), // Added
        'createdAt': Timestamp.now(),
        'totalCommission': 0, // From your project plan
      });

      if (!mounted) return; // Check if widget is still in tree
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created ✅')),
      );
      Navigator.pop(context); // Go back to login screen
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Signup failed')),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  // 6. Added dispose method for controllers
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  // 7. Moved Build method here
  @override
  Widget build(BuildContext context) {
    // Get the total screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // We use a Stack to layer the header and the form card
      body: Stack(
        children: [
          // 1. The Purple Header
          _buildHeader(screenSize),

          // 2. The White Form Card
          _buildFormCard(screenSize),
        ],
      ),
    );
  }

  // Helper widget for the purple header (No changes)
  Widget _buildHeader(Size screenSize) {
    return Container(
      height: screenSize.height * 0.4, // Roughly 40% of the screen
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xFFFCD34D), // Yellowish color
            size: 48.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            "Hostel Canteen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0, // 1.8rem
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            "Connect (HCC)",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9), // e0e7ff
              fontSize: 14.0, // 0.9rem
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper widget for the white form card
  Widget _buildFormCard(Size screenSize) {
    return Positioned(
      // Position it 28% from the top, just like the CSS
      top: screenSize.height * 0.28,
      // 1rem (16.0) padding on left and right
      left: 16.0,
      right: 16.0,
      bottom: 0, // <-- FIX: Pin the card to the bottom of the Stack
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          // FIX: Only round the top corners since it touches the bottom
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Softer shadow
              blurRadius: 25.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Create Your Account",
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 24.0, // 1.5rem
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24.0), // 1.5rem

              // 8. Connected controllers to text fields
              _buildTextField(
                  placeholder: "Full Name", controller: _nameController),
              const SizedBox(height: 16.0), // 1rem
              _buildTextField(
                  placeholder: "Email", controller: _emailController),
              const SizedBox(height: 16.0),
              _buildTextField(
                  placeholder: "Password",
                  controller: _passwordController,
                  isObscure: true),
              const SizedBox(height: 16.0),
              // 9. Added "Confirm Password" field for the logic
              _buildTextField(
                  placeholder: "Confirm Password",
                  controller: _confirmPasswordController,
                  isObscure: true),
              const SizedBox(height: 16.0),
              _buildTextField(
                  placeholder: "Mobile Number", controller: _mobileController),
              const SizedBox(height: 16.0),
              _buildTextField(
                  placeholder: "Room Number", controller: _roomController),
              const SizedBox(height: 24.0), // 1.5rem

              // 10. Added loading check for button
              _loading
                  ? const CircularProgressIndicator() // Show loading spinner
                  : Container(
                      // Show Sign Up Button
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.0), // 0.75rem
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B5CF6).withOpacity(0.3),
                            blurRadius: 10.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap:
                              registerUser, // 11. Connected to registerUser
                          borderRadius: BorderRadius.circular(12.0),
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 14.0), // 0.9rem
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0, // 1rem
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 24.0), // 1.5rem

              // 12. Made "Log In" tappable
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14.0, // 0.875rem
                    fontFamily: 'Inter', // Match default font
                  ),
                  children: [
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: "Log In",
                      style: const TextStyle(
                        color: Color(0xFF6366F1),
                        fontWeight: FontWeight.w600,
                      ),
                      // Added recognizer to make it tappable
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate back to login screen
                          if (Navigator.canPop(context)) {
                             Navigator.pop(context);
                          }
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 13. Modified helper to accept a controller
  Widget _buildTextField(
      {required String placeholder,
      bool isObscure = false,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller, // Set the controller
      obscureText: isObscure,
      keyboardType: placeholder.contains("Mobile")
          ? TextInputType.phone
          : TextInputType.text,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        filled: true,
        fillColor: const Color(0xFFF9FAFB), // Very light bg
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // 0.75rem
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)), // Gray border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          // Purple accent on focus
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2.0),
        ),
      ),
    );
  }
}

