import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';

class PaymentRequestCard extends StatefulWidget {
  final String name;
  final String category;
  final String roll;
  final String amount;
  final String date;
  bool isDone;
  PaymentRequestCard({
    super.key,
    required this.name,
    required this.category,
    required this.roll,
    required this.amount,
    required this.date,
    required this.isDone,
  });

  @override
  State<PaymentRequestCard> createState() => _PaymentRequestCardState();
}

class _PaymentRequestCardState extends State<PaymentRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.category == 'all'
                    ? deepBlue
                    : widget.category == 'paid'
                        ? Colors.green
                        : Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                //    color: Colors.amber,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          "Name : ${widget.name}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          "Roll : ${widget.roll}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 26),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          "Amount : ${widget.amount}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 26),
                        ),
                      ),
                      widget.category == "paid"
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                "Date : ${widget.date}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 26),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              widget.category == 'all'
                  ? Transform.scale(
                      scale: 2.5,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          side: const BorderSide(width: 0.5),
                          shape: const ContinuousRectangleBorder(),
                          value: widget.isDone,
                          onChanged: (value) {
                            // Do api call inside the value, if isDone == true then do POST api call esle UPDATE
                            setState(() {
                              widget.isDone = value!;
                            });
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
