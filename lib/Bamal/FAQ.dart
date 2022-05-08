import 'package:flutter/material.dart';
import 'package:sgj/Bamal/select.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("FAQ"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Is jewellery from SGJ 100% real and certified?",
                  style: TextStyle(fontSize: 16, fontFamily: 'RobotoMono'),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "Absolutely. Our entire collection, be it yellow, white or rose gold, is 100% pure gold, through and through. We use 22carat and 18carat real gold to make our jewellery across all categories. Our diamonds and gemstones too are completely original and certified. We have the SGL and IGI certification to authenticate our diamonds and gold. Furthermore, SGJ is an all-inclusive Hallmarked jewellery Brand."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "What is your Return Policy?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "We have a 30-day return policy. Which means that you have 30 days from the date of delivery to request for return. Once you raise the return request, we will arrange for a pickup within the next 48 hours from your doorstep. You will get 100 % refund to your bank account or you can use the same amount for your next purchase at Melorra."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "How do you ship the product?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "Our logistics partners are Sequel Global Logistics & Ecom Express. We ship our products with tamper proof package and all our products are insured until it reaches you."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "What's the idea behind fashion-inspired jewellery?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "When your apparel can be inspired by fashion, why can’t your jewellery be? We believe that every millennial woman should always let her clothes, as well as her jewellery be on point, and on par with the latest fashion trends. Hence, every single piece of jewellery at Melorra is inspired by fashion, and designed to be in tune with the latest trends from the fashion industry."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Can I exchange my Melorra Jewellery?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "Yes, we offer an exchange within 30 days for the entire value. We also have a lifetime exchange policy which offers 90% exchange value across all jewellery categories. The timelines for the Lifetime Exchange start post the 30-day refund threshold. The process of exchange starts with a quality check of the product; after which, we provide the exchange value. You can then use that value to purchase any other product from our collection."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "What is the mode of payments you offer?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "We have 4 modes of payment at the moment - Cash on Delivery, Card on Delivery, Net banking and Debit/ Credit Card payment. The cash on delivery and card on delivery option is available at select locations only."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Are there any additional or hidden costs?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "No, there are no additional or hidden costs. Only 3% GST, which is already added to the price of the jewellery that you see on the website."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "What is the estimated delivery time for Melorra products?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "Our delivery timeframe for your order would be 12- 15 business days. However, if you buy jewellery from our quick ship category, it will be dispatched within the next 24 hours of the order."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Do you ship all over India?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "We ship to over 25,000 Pincodes, which includes cities like Delhi, Guwahati, Mumbai, Raipur, Hyderabad, Chennai, Patna, Bangalore and many more. Please contact our Customer Service team for more information."),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Does SGJ have an offline store?",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                ),
                // trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  onPressed: () {
                    print("Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(
                            "No, we do not have a physical store. We are a digital jewellery store and you can shop for our entire collection on our website. Through this, we plan to give you a flawless and hassle-free jewellery shopping experience, every single time."),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
