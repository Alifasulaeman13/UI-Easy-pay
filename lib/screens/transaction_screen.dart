import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Colors
  static const Color primaryColor = Color(0xFF1B3A6B);
  static const Color secondaryColor = Color(0xFF2C5BA6);

  // Dummy data
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Transfer ke Anna',
      description: 'Pembayaran invoice #123',
      amount: -500000,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.transferOut,
      recipientName: 'Anna Smith',
      bankName: 'Bank ABC',
      accountNumber: '1234567890',
    ),
    Transaction(
      id: '2',
      title: 'Terima dari John',
      description: 'Pembayaran project',
      amount: 1000000,
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: TransactionType.transferIn,
      recipientName: 'John Doe',
      bankName: 'Bank XYZ',
      accountNumber: '0987654321',
    ),
    // Tambahkan transaksi dummy lainnya...
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTransactionCard(Transaction transaction) {
    final isExpense = transaction.amount < 0;
    final statusColor = transaction.status == TransactionStatus.success
        ? Colors.green
        : transaction.status == TransactionStatus.pending
            ? Colors.orange
            : Colors.red;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to transaction detail
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (isExpense ? Colors.red : Colors.green)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        transaction.type.icon,
                        color: isExpense ? Colors.red : Colors.green,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transaction.description,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currencyFormatter.format(transaction.amount.abs()),
                          style: TextStyle(
                            color: isExpense ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            transaction.status.name.toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (transaction.bankName != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${transaction.bankName} • ${transaction.accountNumber}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Transaksi',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Pemasukan'),
            Tab(text: 'Pengeluaran'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, secondaryColor],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Pemasukan',
                  'Rp 5.000.000',
                  Icons.arrow_downward,
                  Colors.green,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white24,
                ),
                _buildSummaryItem(
                  'Pengeluaran',
                  'Rp 2.500.000',
                  Icons.arrow_upward,
                  Colors.red,
                ),
              ],
            ),
          ),

          // Transaction List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Semua Transaksi
                ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    return _buildTransactionCard(_transactions[index]);
                  },
                ),
                // Pemasukan
                ListView.builder(
                  itemCount: _transactions.where((t) => t.amount > 0).length,
                  itemBuilder: (context, index) {
                    final incomingTransactions =
                        _transactions.where((t) => t.amount > 0).toList();
                    return _buildTransactionCard(incomingTransactions[index]);
                  },
                ),
                // Pengeluaran
                ListView.builder(
                  itemCount: _transactions.where((t) => t.amount < 0).length,
                  itemBuilder: (context, index) {
                    final outgoingTransactions =
                        _transactions.where((t) => t.amount < 0).toList();
                    return _buildTransactionCard(outgoingTransactions[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
