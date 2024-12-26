import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? recipientName;
  final String? bankName;
  final String? accountNumber;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    this.recipientName,
    this.bankName,
    this.accountNumber,
    this.status = TransactionStatus.success,
  });
}

enum TransactionType { transferOut, transferIn, bill, topUp, withdrawal }

enum TransactionStatus { pending, success, failed }

// Extension untuk memudahkan konversi enum ke string
extension TransactionTypeExtension on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.transferOut:
        return 'Transfer Keluar';
      case TransactionType.transferIn:
        return 'Transfer Masuk';
      case TransactionType.bill:
        return 'Pembayaran';
      case TransactionType.topUp:
        return 'Top Up';
      case TransactionType.withdrawal:
        return 'Penarikan';
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.transferOut:
        return Icons.arrow_upward;
      case TransactionType.transferIn:
        return Icons.arrow_downward;
      case TransactionType.bill:
        return Icons.receipt_long;
      case TransactionType.topUp:
        return Icons.account_balance_wallet;
      case TransactionType.withdrawal:
        return Icons.money;
    }
  }
}
