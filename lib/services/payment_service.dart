import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  void initPayment() {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(double amount) {
    var options = {
      'key': 'rzp_test_xxxxxxxxx', // Use TEST key first
      'amount': (amount * 100).toInt(), // in paise
      'name': 'SattvikPlate',
      'description': 'Food Order Payment',
      'prefill': {
        'contact': '7066998333',
        'email': 'rohit@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: ${response.paymentId}");

    // 🔐 Send paymentId to backend for verification
    verifyPaymentFromServer(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }

  void verifyPaymentFromServer(String? paymentId) {
    // Call your API here
  }
}