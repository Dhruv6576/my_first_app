import 'package:flutter/material.dart';

// Note: We removed main(), MyApp, Scaffold, AppBar, and BottomNavigationBar
// This is now just a page widget that can be placed inside another screen.

class RequestedOrdersPage extends StatefulWidget {
  const RequestedOrdersPage({super.key});

  @override
  State<RequestedOrdersPage> createState() => _RequestedOrdersPageState();
}

class _RequestedOrdersPageState extends State<RequestedOrdersPage> {
  // 0 = Pending, 1 = Accepted
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // Return the Column directly, not a Scaffold
    return Column(
      children: [
        // Pending/Accepted Tabs
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: _buildTabButton(
                  label: 'Pending',
                  index: 0,
                  onTap: () {
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTabButton(
                  label: 'Accepted',
                  index: 1,
                  onTap: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        // The list of orders
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              // Example Order Cards
              _buildOrderCard(
                productImage: 'assets/coca_cola.png', // Placeholder
                productName: 'Coca-Cola (300ml)', // Just for visual cue
                buyerName: 'Dhruv',
                roomNo: '407',
                totalItems: 8,
                totalRupees: 350,
                status: 'Pending',
              ),
              _buildOrderCard(
                productImage: 'assets/coca_cola.png', // Placeholder
                productName: 'Coca-Cola (300ml)',
                buyerName: 'Dhruv',
                roomNo: '406',
                totalItems: 8,
                totalRupees: 350,
                status: 'Pending',
              ),
              _buildOrderCard(
                productImage: 'assets/coca_cola.png', // Placeholder
                productName: 'Coca-Cola (300ml)',
                buyerName: 'Priya',
                roomNo: '407',
                totalItems: 5,
                totalRupees: 320,
                status: 'Pending',
              ),
              _buildOrderCard(
                productImage: 'assets/parle_g.png', // Placeholder
                productName: 'Parle-G Original',
                buyerName: 'Driya',
                roomNo: '407',
                totalItems: 5,
                totalRupees: 230,
                status: 'Pending',
              ),
              // Add more order cards as needed
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton({
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)], // Purple gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.grey[800], // Dark grey for unselected
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String productImage,
    required String productName, // Added for potential future use
    required String buyerName,
    required String roomNo,
    required int totalItems,
    required int totalRupees,
    required String status,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle tapping on an order card (e.g., show details pop-up)
        print('Order card tapped for $buyerName');
      },
      child: Card(
        color: const Color(0xFF2C2C4A), // Use dark card color
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[700], // Placeholder color
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    // You'll need to add images to your assets folder (e.g., assets/coca_cola.png)
                    // and declare them in pubspec.yaml
                    image: AssetImage(productImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              // Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buyer: $buyerName',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Room No: $roomNo',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Total Items: $totalItems',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Total ₹: $totalRupees',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Status Tag
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.orange[700], // Pending status color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Status: $status',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

