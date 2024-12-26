import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  static const Color primaryColor = Color(0xFF1B3A6B);
  static const Color secondaryColor = Color(0xFF2C5BA6);
  static const Color backgroundColor = Color(0xFFF8F9FE);

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Daftar jenis travel
  final List<Map<String, dynamic>> _travelTypes = [
    {
      'name': 'Pesawat',
      'icon': Icons.flight,
      'code': 'FLIGHT',
    },
    {
      'name': 'Kereta Api',
      'icon': Icons.train,
      'code': 'TRAIN',
    },
    {
      'name': 'Bus',
      'icon': Icons.directions_bus,
      'code': 'BUS',
    },
    {
      'name': 'Hotel',
      'icon': Icons.hotel,
      'code': 'HOTEL',
    },
    {
      'name': 'Rental Mobil',
      'icon': Icons.car_rental,
      'code': 'CAR',
    },
    {
      'name': 'Tour',
      'icon': Icons.tour,
      'code': 'TOUR',
    },
  ];

  String? _selectedType;
  DateTime? _selectedDate;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  // Riwayat pemesanan travel
  final List<Map<String, dynamic>> _bookingHistory = [
    {
      'type': 'Pesawat',
      'from': 'Jakarta (CGK)',
      'to': 'Bali (DPS)',
      'date': '2024-03-20',
      'amount': 1250000,
      'status': 'Confirmed',
      'icon': Icons.flight,
    },
    {
      'type': 'Kereta Api',
      'from': 'Jakarta (GMR)',
      'to': 'Bandung (BD)',
      'date': '2024-03-15',
      'amount': 350000,
      'status': 'Completed',
      'icon': Icons.train,
    },
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Travel & Booking',
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
            // Travel Type Grid
            const Text(
              'Pilih Jenis Travel',
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
              itemCount: _travelTypes.length,
              itemBuilder: (context, index) {
                final type = _travelTypes[index];
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

            // Travel Form
            const SizedBox(height: 24),
            if (_selectedType != null) ...[
              Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    // From field
                    TextField(
                      controller: _fromController,
                      decoration: InputDecoration(
                        labelText: 'Dari',
                        prefixIcon: const Icon(Icons.location_on_outlined,
                            color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // To field
                    TextField(
                      controller: _toController,
                      decoration: InputDecoration(
                        labelText: 'Ke',
                        prefixIcon: const Icon(Icons.location_on_outlined,
                            color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Date picker
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: primaryColor),
                            const SizedBox(width: 12),
                            Text(
                              _selectedDate == null
                                  ? 'Pilih Tanggal'
                                  : DateFormat('dd MMM yyyy')
                                      .format(_selectedDate!),
                              style: TextStyle(
                                color: _selectedDate == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Booking History
            const SizedBox(height: 24),
            const Text(
              'Riwayat Pemesanan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ..._bookingHistory.map((booking) => Container(
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
                          booking['icon'] as IconData,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${booking['from']} → ${booking['to']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${booking['type']} - ${booking['date']}',
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
                            currencyFormatter.format(booking['amount']),
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
                              booking['status'],
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
          onPressed: _selectedType != null &&
                  _fromController.text.isNotEmpty &&
                  _toController.text.isNotEmpty &&
                  _selectedDate != null
              ? () {
                  // Implement booking logic
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
            'Cari',
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
