import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/Payment/widget/payment_request_card.dart';
import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class PaymentRequestScreen extends StatefulWidget {
  final String selectedClass;
  final String selectedSection;
  const PaymentRequestScreen(
      {super.key, required this.selectedClass, required this.selectedSection});

  @override
  State<PaymentRequestScreen> createState() => _PaymentRequestScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PaymentRequestScreenState extends State<PaymentRequestScreen>
    with TickerProviderStateMixin {
  String searchText = '';
  bool isClicked = false;
  late DateTime _selectedDate;
  late TabController _tabController;
  String currentTab = "all";

  List name = [
    "Arpan Mukherjee",
    "Gautam Mehta",
    "Harsh Purohit",
    "Mrityunjay kumar",
    "Anjali Patel",
    "Baishakhi Dutta"
  ];
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          currentTab = "all";
          break;
        case 1:
          currentTab = "paid";
          break;
        case 2:
          currentTab = "not_paid";
          break;
      }
    });
  }

  void _showMonthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300,
            width: 300,
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(DateTime.now().year - 10),
              lastDate: DateTime(DateTime.now().year + 10),
              initialCalendarMode: DatePickerMode.year,
              onDateChanged: (DateTime picked) {
                setState(() {
                  _selectedDate = picked;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Rebuild");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.3,
          ),
          child: DecorativeAppBar(
            barHeight: MediaQuery.of(context).size.height * 0.20,
            barPad: MediaQuery.of(context).size.height * 0.16,
            radii: 30,
            background: Colors.white,
            gradient1: lightBlue,
            gradient2: deepBlue,
            extra: appbar("assets/flaticon/fees_appbar.png", "Payment", context,
                () {
              Navigator.pop(context);
            }),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Container(
                height: height * 0.07,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: deepBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: deepBlue), // Color when focused
                    ),
                  ),
                ),
              ),
            ),
            //.........
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // log("Prevuous date : " + _selectedDate.toString());
                    log("Current Tab : " + currentTab);
                    return _previousMonth();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                InkWell(
                  onTap: _showMonthPicker,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMM().format(_selectedDate),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    log("Next date : " + _selectedDate.toString());
                    return _nextMonth();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),

            //...
            Container(
              //  color: Colors.grey,
              child: TabBar(
                indicatorColor: deepBlue,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    child: Text(
                      "All",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Paid",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Not-Paid",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: name.length,
                    itemBuilder: (context, index) {
                      final title = name[index];
                      final lowerCaseTitle = name[index].toLowerCase();

                      if (searchText.isEmpty ||
                          lowerCaseTitle.contains(searchText)) {
                        return PaymentRequestCard(
                          name: name[index],
                          category: "all",
                          roll: "123",
                          amount: "50",
                          date: "2024-02-26",
                          isDone: isDone,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  ListView.builder(
                    itemCount: name.length,
                    itemBuilder: (context, index) {
                      final title = name[index];
                      final lowerCaseTitle = name[index].toLowerCase();

                      if (searchText.isEmpty ||
                          lowerCaseTitle.contains(searchText)) {
                        return PaymentRequestCard(
                          name: name[index],
                          category: "paid",
                          roll: "123",
                          amount: "50",
                          date: "2024-02-26",
                          isDone: isDone,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),

                  //...............................................
                  ListView.builder(
                    itemCount: name.length,
                    itemBuilder: (context, index) {
                      final title = name[index];
                      final lowerCaseTitle = name[index].toLowerCase();

                      if (searchText.isEmpty ||
                          lowerCaseTitle.contains(searchText)) {
                        return PaymentRequestCard(
                          name: name[index],
                          category: "Not Paid",
                          roll: "123",
                          amount: "50",
                          date: "2024-02-26",
                          isDone: isDone,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
