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

  // --- 2. CREATE A LIST OF YOUR PAGES ---
  // We'll put the product grid in a separate widget
  // and add the other pages.
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeProductGrid(), // Your product grid (defined below)
    const RequestedOrdersPage(), // Your orders page
    const Center(
      child: Text('Category Page', style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text('Cart Page', style: TextStyle(color: Colors.white)),
    ),
  ];

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // --- 3. DYNAMIC APPBAR REMOVED ---
  // The _buildAppBar() function has been removed.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      // --- 4. REPLACED WITH ORIGINAL APPBAR ---
      // The dynamic _buildAppBar() call is replaced with the
      // original dark AppBar, which will now show on all pages.
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Welcome ${user?.email?.split('@')[0] ?? 'User'} 👋\nTo Tomato 🍅',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),
            ),
            IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
      body:
          _widgetOptions.elementAt(_selectedIndex), // <-- 5. SHOW THE SELECTED PAGE
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF00B04B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}

// --- 6. EXTRACTED YOUR HOME PAGE CONTENT ---
// This widget contains your original product grid.
class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({super.key});

  // Copied your product list here
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
        // ... (rest of your products) ...
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
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg' // <-- FIX 1
        },
        {
          'name': 'Banana',
          'weight': '1 dozen',
          'price': '₹58',
          'mrp': '₹65',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg'
        },
        {
          'name': 'Potato',
          'weight': '1 kg',
          'price': '₹29',
          'mrp': '₹35',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/a/ab/Patates.jpg'
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
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg' // <-- FIX 2
        },
        {
          'name': 'Tata Salt',
          'weight': '1 kg',
          'price': '₹22',
          'mrp': '₹25',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg' // <-- FIX 3
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
    return Column(
      children: [
        // Search bar
        Container(
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for atta, dal, coke and more...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),

        // Section Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Bestsellers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Product Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final p = _products[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            child: Image.network(
                              p['image'],
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              // Add error handling for images
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 90,
                                  color: Colors.grey[800],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF00B04B),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: const Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['weight'],
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11)),
                            const SizedBox(height: 2),
                            Text(
                              p['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  p['price'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
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
          ),
        ),
      ],
    );
  }
}


