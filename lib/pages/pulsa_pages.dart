import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PulsaPage extends StatefulWidget {
  const PulsaPage({super.key});

  @override
  State<PulsaPage> createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  static const Color primaryColor = Color(0xFF1B3A6B);
  static const Color secondaryColor = Color(0xFF2C5BA6);
  static const Color backgroundColor = Color(0xFFF8F9FE);

  final TextEditingController _phoneNumberController = TextEditingController();
  String? _selectedOperator;
  int? _selectedAmount;

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Data operator seluler
  final List<Map<String, dynamic>> _operators = [
    {
      'name': 'Telkomsel',
      'logo': 'assets/telkomsel.png',
    },
    {
      'name': 'Indosat',
      'logo': 'assets/indosat.png',
    },
    {
      'name': 'XL',
      'logo': 'assets/xl.png',
    },
    {
      'name': 'Tri',
      'logo': 'assets/tri.png',
    },
  ];

  // Paket pulsa
  final List<Map<String, dynamic>> _pulsaPackages = [
    {
      'amount': 5000,
      'bonus': 'Masa aktif 7 hari',
    },
    {
      'amount': 10000,
      'bonus': 'Masa aktif 14 hari',
    },
    {
      'amount': 20000,
      'bonus': 'Masa aktif 30 hari',
    },
    {
      'amount': 50000,
      'bonus': 'Masa aktif 60 hari',
    },
    {
      'amount': 100000,
      'bonus': 'Masa aktif 90 hari',
    },
    {
      'amount': 200000,
      'bonus': 'Masa aktif 180 hari',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Isi Pulsa',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone number input
            const Text(
              'Nomor Telepon',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Container(
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
              child: TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukkan nomor telepon',
                  prefixIcon:
                      const Icon(Icons.phone_android, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            // Operator selection
            const SizedBox(height: 24),
            const Text(
              'Pilih Operator',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _operators.length,
                itemBuilder: (context, index) {
                  final operator = _operators[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOperator = operator['name'];
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: _selectedOperator == operator['name']
                            ? secondaryColor.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedOperator == operator['name']
                              ? secondaryColor
                              : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sim_card_outlined,
                            color: _selectedOperator == operator['name']
                                ? secondaryColor
                                : Colors.grey,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            operator['name'],
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedOperator == operator['name']
                                  ? secondaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Pulsa packages
            const SizedBox(height: 24),
            const Text(
              'Pilih Nominal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: _pulsaPackages.length,
              itemBuilder: (context, index) {
                final package = _pulsaPackages[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAmount = package['amount'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedAmount == package['amount']
                          ? secondaryColor
                          : Colors.white,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currencyFormatter.format(package['amount']),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _selectedAmount == package['amount']
                                ? Colors.white
                                : primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          package['bonus'],
                          style: TextStyle(
                            fontSize: 12,
                            color: _selectedAmount == package['amount']
                                ? Colors.white.withOpacity(0.8)
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _selectedAmount != null && _selectedOperator != null
              ? () {
                  // Implement payment logic
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Beli Sekarang',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
