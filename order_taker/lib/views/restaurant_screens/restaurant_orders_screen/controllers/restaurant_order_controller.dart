import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantOrderNotifier extends StateNotifier<void> {
  RestaurantOrderNotifier() : super(null);

  void seeAdditionalMessages(BuildContext context, String additionalMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Additional messages.'),
        content: Center(
          child: Text(additionalMessage),
        ),
      ),
    );
  }
  void setStatus(int orderId){



  }
}
