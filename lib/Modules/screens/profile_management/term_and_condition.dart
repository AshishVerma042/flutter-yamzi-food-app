import 'package:flutter/material.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

import '../customThaliManagement/Customization_Thali.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar:  appBar("Terms & Conditions"),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    14.kH,

                    Text(
                      "By using our application, you agree to the following terms:",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),

                    16.kH,

                    bullet("Use the app responsibly and ethically."),
                    bullet("Do not attempt to hack, misuse, or exploit the application."),
                    bullet("Payments made within the app are non-refundable."),
                    bullet("All information you provide must be accurate and valid."),
                    bullet("Terms may be updated from time to time without notice."),

                    20.kH,

                    Row(
                      children: [
                        Icon(Icons.email_outlined, size: 20, color: Colors.orange),
                        10.kW,
                        Expanded(
                          child: Text(
                            "For any support, contact us at: support@example.com",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          10.kW,
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
