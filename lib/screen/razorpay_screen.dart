
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({Key? key}) : super(key: key);

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  
  final Razorpay _razorPay = Razorpay();
  
  
  @override
  initState(){
    super.initState();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccessEvent);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
  }

  void _handleSuccessEvent(PaymentSuccessResponse response){
    print("PaymentSuccessResponse paymentId---->${response.paymentId!}-----");
    print("PaymentSuccessResponse orderId---->${response.orderId }");
    print("PaymentSuccessResponse signature---->${response.signature }");

  }

  void _handlePaymentError(PaymentFailureResponse response){

    print("PaymentFailureResponse ---->${response.code}${response.message!}");

  }

  void _handlePaymentWallet(ExternalWalletResponse response){

    print("ExternalWalletResponse---->$response");
  }


  @override
  dispose(){
    super.dispose();
    _razorPay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_IPcAYW8pa5KjJ3',
      'amount': 1000*100,
      'name': 'Go Visible ',
      'description': 'One Year Subscription ',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '7990381041', 'email': 'test@razorpay.com'},
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: GestureDetector(
            onTap: (){
              openCheckout();
            },
            child: const Text("Do the payment")),
      ),

    );
  }
}
