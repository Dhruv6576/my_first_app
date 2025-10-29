import 'package:flutter/material.dart';

// This is now a StatefulWidget to manage the selected tab
class RequestedOrdersPage extends StatefulWidget {
  const RequestedOrdersPage({super.key});

  @override
  State<RequestedOrdersPage> createState() => _RequestedOrdersPageState();
}

class _RequestedOrdersPageState extends State<RequestedOrdersPage> {
  // 0 = Pending, 1 = Accepted, 2 = Your Order
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use the same light grey background as the home page
      color: const Color(0xFFF4F7FB),
      child: Column(
        children: [
          // --- 1. THREE-TAB SELECTOR ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    label: 'Pending',
                    index: 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _buildTabButton(
                    label: 'Accepted',
                    index: 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _buildTabButton(
                    label: 'Your Order',
                    index: 2,
                    onTap: () => setState(() => _selectedTab = 2),
                  ),
                ),
              ],
            ),
          ),

          // --- 2. CONDITIONAL LIST VIEW ---
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                // --- PENDING ORDERS LIST (Tab 0) ---
                // This list shows orders for the RUNNER to accept
                _buildOrdersList(
                  key: const ValueKey('pending'), // Add keys for state
                  orders: [
                    // Example data
                    const OrderCardData(
                      title: 'Buyer: Dhruv',
                      subtitle: 'Room No: 407',
                      items: 8,
                      price: 350,
                      status: 'Pending',
                      statusColor: Colors.orange,
                    ),
                    const OrderCardData(
                      title: 'Buyer: Priya',
                      subtitle: 'Room No: 201',
                      items: 2,
                      price: 80,
                      status: 'Pending',
                      statusColor: Colors.orange,
                    ),
                  ],
                ),

                // --- ACCEPTED ORDERS LIST (Tab 1) ---
                // This list shows orders the RUNNER has accepted
                _buildOrdersList(
                  key: const ValueKey('accepted'),
                  orders: [
                    const OrderCardData(
                      title: 'Buyer: Rohan',
                      subtitle: 'Room No: 112',
                      items: 5,
                      price: 150,
                      status: 'Accepted',
                      statusColor: Colors.blue,
                    ),
                  ],
                ),

                // --- YOUR ORDERS LIST (Tab 2) ---
                // This list shows orders the USER has placed
                _buildOrdersList(
                  key: const ValueKey('your_orders'),
                  orders: [
                    const OrderCardData(
                      title: 'Runner: Karan', // Shows who the runner is
                      subtitle: 'Delivering to Room: 407',
                      items: 8,
                      price: 350,
                      status: 'Accepted',
                      statusColor: Colors.blue,
                    ),
                    const OrderCardData(
                      title: 'Waiting for Runner...',
                      subtitle: 'Delivering to Room: 407',
                      items: 3,
                      price: 120,
                      status: 'Pending',
                      statusColor: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tab Button Widget
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
          // Use gradient if selected, light grey if not
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // List View Widget
  Widget _buildOrdersList({required Key key, required List<OrderCardData> orders}) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders in this category.',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        order.subtitle,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            'Total Items: ${order.items}',
                            style: TextStyle(color: Colors.grey[800], fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Total ₹: ${order.price}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status Tag
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: order.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: order.statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// A simple class to hold order data
class OrderCardData {
  final String title;
  final String subtitle;
  final int items;
  final int price;
  final String status;
  final Color statusColor;

  const OrderCardData({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.price,
    required this.status,
    required this.statusColor,
  });
}

