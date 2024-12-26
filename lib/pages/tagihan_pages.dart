import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  static const Color primaryColor = Color(0xFF1B3A6B);
  static const Color secondaryColor = Color(0xFF2C5BA6);
  static const Color backgroundColor = Color(0xFFF8F9FE);

  final TextEditingController _customerNumberController =
      TextEditingController();
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Daftar jenis tagihan
  final List<Map<String, dynamic>> _tagihanTypes = [
    {
      'name': 'IndiHome',
      'icon': Icons.wifi,
      'code': 'INDIHOME',
    },
    {
      'name': 'TV Kabel',
      'icon': Icons.tv,
      'code': 'TV',
    },
    {
      'name': 'BPJS',
      'icon': Icons.local_hospital,
      'code': 'BPJS',
    },
    {
      'name': 'PBB',
      'icon': Icons.home_work,
      'code': 'PBB',
    },
    {
      'name': 'Kartu Kredit',
      'icon': Icons.credit_card,
      'code': 'CC',
    },
    {
      'name': 'Internet',
      'icon': Icons.router,
      'code': 'INTERNET',
    },
  ];

  String? _selectedType;

  // Riwayat pembayaran tagihan
  final List<Map<String, dynamic>> _paymentHistory = [
    {
      'type': 'IndiHome',
      'customerNumber': '1234567890',
      'customerName': 'John Doe',
      'date': '2024-03-15',
      'amount': 350000,
      'status': 'Berhasil',
      'period': 'Maret 2024',
      'icon': Icons.wifi,
    },
    {
      'type': 'BPJS',
      'customerNumber': '0987654321',
      'customerName': 'Jane Smith',
      'date': '2024-03-10',
      'amount': 150000,
      'status': 'Berhasil',
      'period': 'Maret 2024',
      'icon': Icons.local_hospital,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Pembayaran Tagihan',
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
            // Jenis Tagihan Grid
            const Text(
              'Pilih Jenis Tagihan',
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
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _tagihanTypes.length,
              itemBuilder: (context, index) {
                final type = _tagihanTypes[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedType = type['code'] as String;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedType == type['code']
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          type['icon'] as IconData,
                          color: _selectedType == type['code']
                              ? Colors.white
                              : primaryColor,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type['name'] as String,
                          style: TextStyle(
                            color: _selectedType == type['code']
                                ? Colors.white
                                : primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Customer number input
            const SizedBox(height: 24),
            const Text(
              'Nomor Pelanggan',
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
                controller: _customerNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Masukkan nomor pelanggan',
                  prefixIcon:
                      const Icon(Icons.person_outline, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            // Payment history
            const SizedBox(height: 24),
            const Text(
              'Riwayat Pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ..._paymentHistory.map((payment) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
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
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          payment['icon'] as IconData,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${payment['type']} - ${payment['customerName']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Periode: ${payment['period']}',
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
                            currencyFormatter.format(payment['amount']),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              payment['status'],
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
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
          onPressed:
              _selectedType != null && _customerNumberController.text.isNotEmpty
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
            'Cek Tagihan',
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
