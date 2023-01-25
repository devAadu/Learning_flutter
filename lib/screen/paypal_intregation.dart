import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PaypalIntegration extends StatefulWidget {
  const PaypalIntegration({Key? key}) : super(key: key);

  @override
  State<PaypalIntegration> createState() => _PaypalIntegrationState();
}

class _PaypalIntegrationState extends State<PaypalIntegration> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          payment();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          child: const Padding(
            padding:  EdgeInsets.all(10.0),
            child: Text("Make Payment"),
          ),
        ),
      ),
    );
  }

  void payment(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId: "ARs-BHe0Rz9kKsFKdh5ZU2iKrWoqW5gM0zjdy9a72wHf0Qot52VTp6PTt_pWqBRIbr7Y3exARTHHPn6Y",
            secretKey: "EEp7bLWNX4iOTYoIy-BVB8F2pJ8W25OXaP-JUi0ych3jCilIIqY5mmgh6FcK7sV7ItK-Ez",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: const [
              {
                "amount": {
                  "total": '10.12',
                  "currency": "USD",
                  "details": {
                    "subtotal": '10.12',
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description":
                "The payment transaction description.",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {
                      "name": "A demo product",
                      "quantity": 1,
                      "price": '10.12',
                      "currency": "USD"
                    }
                  ],

                  // shipping address is not required though
                  "shipping_address": {
                    "recipient_name": "Jane Foster",
                    "line1": "Travis County",
                    "line2": "",
                    "city": "Austin",
                    "country_code": "US",
                    "postal_code": "73301",
                    "phone": "+00000000",
                    "state": "Texas"
                  },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              print("onSuccess: $params");
            },
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            }),
      ),
    );
  }
}
