import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'requested_orders_screen.dart'; // <-- 1. IMPORT YOUR ORDERS PAGE

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  // --- 2. YOUR LIST OF PAGES (FIXED ORDER) ---
  // This list now correctly matches the bottom navigation bar
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeProductGrid(), // Index 0: Home
    const Center(
      // Index 1: Category
      child: Text('Category Page', style: TextStyle(color: Colors.black)), // Text color changed
    ),
    const RequestedOrdersPage(), // Index 2: Orders
    const Center(
      // Index 3: Cart
      child: Text('Cart Page', style: TextStyle(color: Colors.black)), // Text color changed
    ),
  ];

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // --- 3. DYNAMIC APPBAR LOGIC ---
  PreferredSizeWidget _buildAppBar() {
    String titleText;

    switch (_selectedIndex) {
      case 0: // Home
        titleText =
            'Welcome to our app,\n${user?.email?.split('@')[0] ?? 'User'}';
        break;
      case 1: // Category
        titleText = 'Categories';
        break;
      case 2: // Orders
        titleText = 'Requested Orders'; // Title for the orders page
        break;
      case 3: // Cart
        titleText = 'Your Cart';
        break;
      default:
        titleText = 'Hostel Canteen';
    }

    return AppBar(
      elevation: 0,
      toolbarHeight: 80, // Taller AppBar
      automaticallyImplyLeading: false,
      // --- 4. LIGHT GRADIENT APPBAR ---
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Light purple gradient
            colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              titleText, // Use the dynamic title
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) { // <-- Corrected typo here
    // --- 5. UPDATED SCAFFOLD FOR LIGHT MODE ---
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA), // Main light background
      appBar: _buildAppBar(), // Use the dynamic AppBar
      body:
          _widgetOptions.elementAt(_selectedIndex), // Show the selected page
      // --- 6. LIGHT BOTTOMNAVBAR ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Light nav background
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF6366F1), // Purple selected
        unselectedItemColor: Colors.grey[500], // Grey unselected
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => _selectedIndex = index),
        // These items now match the _widgetOptions list order
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'), // Index 0
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Category'), // Index 1
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Orders'), // Index 2
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'), // Index 3
        ],
      ),
    );
  }
}

// --- 7. HOME PAGE CONTENT (UPDATED FOR LIGHT UI) ---
class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({super.key});

  // Your product list
  List<Map<String, dynamic>> get _products => const [
        {
          'name': 'Onion (Dungdi)',
          'weight': '1 kg',
          'price': '₹26',
          'mrp': '₹33',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Amul Gold Milk',
          'weight': '500 ml',
          'price': '₹34',
          'mrp': '₹38',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Coriander (Kothmir)',
          'weight': '100 g',
          'price': '₹16',
          'mrp': '₹20',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Tomato (Hybrid)',
          'weight': '500 g',
          'price': '₹17',
          'mrp': '₹21',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Green Chilli',
          'weight': '100 g',
          'price': '₹14',
          'mrp': '₹18',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Amul Masti Curd',
          'weight': '1 kg',
          'price': '₹77',
          'mrp': '₹90',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Banana',
          'weight': '1 dozen',
          'price': '₹58',
          'mrp': '₹65',
          'image':
              'https.upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg'
        },
        {
          'name': 'Potato',
          'weight': '1 kg',
          'price': '₹29',
          'mrp': '₹35',
          'image':
              'https.upload.wikimedia.org/wikipedia/commons/a/ab/Patates.jpg'
        },
        {
          'name': 'Apple Shimla',
          'weight': '1 kg',
          'price': '₹150',
          'mrp': '₹170',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg'
        },
        {
          'name': 'Britannia Bread',
          'weight': '400 g',
          'price': '₹40',
          'mrp': '₹45',
          'image':
              'https.upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Tata Salt',
          'weight': '1 kg',
          'price': '₹22',
          'mrp': '₹25',
          'image':
              'https.upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
        {
          'name': 'Amul Butter',
          'weight': '500 g',
          'price': '₹260',
          'mrp': '₹280',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
        },
      ];
@override
Widget build(BuildContext context) {
  return SafeArea( // <-- Add SafeArea here
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Search Bar ---
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            child: const TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search for items...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Align(),
          ),

          // --- Product Grid ---
          GridView.builder(
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final p = _products[index];
              return Container(
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
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            p['image'],
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            p['weight'],
                            style:
                                const TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                p['price'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                p['mrp'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
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
            },
          ),

          const SizedBox(height: 16), // <-- add bottom padding
        ],
      ),
    ),
  );
}
}