import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});




  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Onion (Dungdi)',
      'weight': '1 kg',
      'price': '₹26',
      'mrp': '₹33',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/2/25/Onion.jpg'
    },
    {
      'name': 'Amul Gold Milk',
      'weight': '500 ml',
      'price': '₹34',
      'mrp': '₹38',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/b/b2/Amul_Gold_Milk.jpg'
    },
    {
      'name': 'Coriander (Kothmir)',
      'weight': '100 g',
      'price': '₹16',
      'mrp': '₹20',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/4/43/Coriander.jpg'
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
          'https://upload.wikimedia.org/wikipedia/commons/6/6f/Green_Chilly.jpg'
    },
    {
      'name': 'Amul Masti Curd',
      'weight': '1 kg',
      'price': '₹77',
      'mrp': '₹90',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/2/27/Amul_Masti_Dahi.jpg'
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
          'https://upload.wikimedia.org/wikipedia/en/3/3d/Britannia_Bread_Pack.jpg'
    },
    {
      'name': 'Tata Salt',
      'weight': '1 kg',
      'price': '₹22',
      'mrp': '₹25',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/4/45/Tata_Salt.jpg'
    },
    {
      'name': 'Amul Butter',
      'weight': '500 g',
      'price': '₹260',
      'mrp': '₹280',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/d/da/Amul_Butter_Pack.jpg'
    },
  ];

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
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
      body: Column(
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
      ),
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