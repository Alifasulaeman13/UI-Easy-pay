import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/topup_pages.dart';
import '../pages/Transfer_pages.dart';
import '../pages/kartu_kredit.dart';
import '../pages/listrik_pages.dart';
import '../pages/pulsa_pages.dart';
import '../pages/air_pages.dart';
import '../pages/tagihan_pages.dart';
import '../pages/travel_pages.dart';
import '../pages/qr_payment_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Colors
  static const Color primaryColor = Color(0xFF1B3A6B);
  static const Color secondaryColor = Color(0xFF2C5BA6);
  static const Color accentColor = Color(0xFF4CAF50);
  static const Color backgroundColor = Color(0xFFF8F9FE);

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Dummy data
  final double _balance = 50903400;
  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'title': 'Transfer ke Anna',
      'amount': -5000000,
      'date': '2024-12-25',
      'type': 'transfer_out',
      'description': 'Pembayaran invoice #123'
    },
    {
      'title': 'Terima dari John',
      'amount': 10000000,
      'date': '2024-12-24',
      'type': 'transfer_in',
      'description': 'Pembayaran project'
    },
    {
      'title': 'Pembayaran Listrik',
      'amount': -250000,
      'date': '2024-03-08',
      'type': 'bill',
      'description': 'PLN Maret 2024'
    },
  ];

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, secondaryColor],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Saldo Tersedia',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Lihat Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            currencyFormatter.format(_balance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildQuickAction(
                icon: Icons.add_circle_outline,
                label: 'Top Up',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TopUpPage()),
                  );
                },
              ),
              const SizedBox(width: 16),
              _buildQuickAction(
                icon: Icons.send_outlined,
                label: 'Transfer',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransferPage()),
                  );
                },
              ),
              const SizedBox(width: 16),
              _buildQuickAction(
                icon: Icons.qr_code_scanner_outlined,
                label: 'Scan QR',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRPaymentPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceMenu() {
    final List<Map<String, dynamic>> services = [
      {
        'icon': Icons.credit_card_outlined,
        'label': 'Kartu',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreditCardPage()),
          );
        }
      },
      {
        'icon': Icons.phone_android_outlined,
        'label': 'Pulsa',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PulsaPage()),
          );
        }
      },
      {
        'icon': Icons.flash_on_outlined,
        'label': 'Listrik',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListrikPage()),
          );
        }
      },
      {
        'icon': Icons.water_drop_outlined,
        'label': 'Air',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AirPage()),
          );
        }
      },
      {
        'icon': Icons.tv_outlined,
        'label': 'Tagihan',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TagihanPage()),
          );
        }
      },
      {
        'icon': Icons.card_travel_outlined,
        'label': 'Travel',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TravelPage()),
          );
        }
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Layanan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B3A6B),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 24,
              crossAxisSpacing: 20,
              childAspectRatio: 0.8,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: services[index]['onTap'],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        services[index]['icon'],
                        color: const Color(0xFF1B3A6B),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      services[index]['label'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1B3A6B),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaksi Terakhir',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._recentTransactions.map(_buildTransactionItem).toList(),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    IconData icon;
    Color color;

    switch (transaction['type']) {
      case 'transfer_out':
        icon = Icons.arrow_upward;
        color = Colors.red;
        break;
      case 'transfer_in':
        icon = Icons.arrow_downward;
        color = accentColor;
        break;
      default:
        icon = Icons.receipt_long;
        color = secondaryColor;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['description'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormatter.format(transaction['amount'].abs()),
                style: TextStyle(
                  color: transaction['amount'] < 0 ? Colors.red : accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['date'],
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Sore,',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Muhamad Alifa Sulaeman',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: primaryColor,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: primaryColor.withOpacity(0.1),
                            child: const Icon(
                              Icons.person_outline,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildBalanceCard(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildServiceMenu(),
              ),
              const SizedBox(height: 20),
              _buildTransactionList(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
