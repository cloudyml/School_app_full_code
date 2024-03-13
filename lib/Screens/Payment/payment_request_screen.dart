import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/Models/Teacher/Payment%20request/teacher_payment_request_response_model.dart';
import 'package:school_management_system/widget/teacher/payment_request_card.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/widget/Role_Control/dashboard_gridview_data.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';

class PaymentRequestScreen extends StatefulWidget {
  final String selectedClass;
  final String selectedSection;
  PaymentRequestScreen(
      {super.key, required this.selectedClass, required this.selectedSection});

  @override
  State<PaymentRequestScreen> createState() => _PaymentRequestScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PaymentRequestScreenState extends State<PaymentRequestScreen>
    with TickerProviderStateMixin {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  TeacherPaymentStatusResponseModel? allData;
  bool isLoading = false;
  String searchText = '';
  bool isClicked = false;
  late DateTime _selectedDate;
  late TabController _tabController;
  String currentTab = "all";

  bool isDone = false;
  List category = ["All", "Paid", "Not Paid"];
  int selectedCategory = 0;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    getData();
    selectedMonth = _selectedDate.month;
    selectedYear = _selectedDate.year;
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    allData = await TeacherApiServices.teacherPaymentRequest(
        widget.selectedClass,
        widget.selectedSection,
        selectedMonth,
        selectedYear);
    filteredData = allData!.data!.studentList!
        .where((element) => element.category == category[selectedCategory])
        .toList();
    log(filteredData.toString());
    setState(() {
      isLoading = false;
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
                  selectedMonth = picked.month;
                  selectedYear = picked.year;
                });
                Navigator.of(context).pop();
                getData();
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
      selectedMonth = _selectedDate.month;
      selectedYear = _selectedDate.year;
    });
    log("Selected Month ====>>>>> ${selectedMonth}");
    log("Selected Year ====>>>>> ${selectedYear}");
    getData();
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
      selectedMonth = _selectedDate.month;
      selectedYear = _selectedDate.year;
    });
    log("Selected Month ====>>>>> ${selectedMonth}");
    log("Selected Year ====>>>>> ${selectedYear}");
    getData();
  }

  List<StudentList> filteredData = [];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String todaysDate = DateFormat('yyyy-MM-dd').format(now);
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
                    //    log("Current Tab : " + currentTab);
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
                    return _nextMonth();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),

            //...
            Container(
              child: TabBar(
                  // controller: _tabController,
                  onTap: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                    log("Category==>>>>>" + category[selectedCategory]);
                    setState(() {
                      filteredData = allData!.data!.studentList!
                          .where((element) =>
                              element.category == category[selectedCategory])
                          .toList();
                      log(filteredData.toString());
                    });
                  },
                  indicatorColor: deepBlue,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  tabs: List.generate(category.length, (index) {
                    return Tab(
                      child: Text(
                        category[index],
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  })),
            ),
            Expanded(
              child: TabBarView(
                  children: List.generate(category.length, (index) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isLoading
                        ? [const CircularProgressIndicator()]
                        : allData?.data?.studentList?.length == null
                            ? []
                            : List.generate((filteredData.length),
                                (internalIndex) {
                                final studentname =
                                    "${filteredData[internalIndex].name}";
                                final lowerCaseTitle =
                                    studentname.toLowerCase();

                                if (searchText.isEmpty ||
                                    lowerCaseTitle.contains(searchText)) {
                                  return PaymentRequestCard(
                                    name: studentname,
                                    category: index == 0
                                        ? "all"
                                        : index == 1
                                            ? "paid"
                                            : "not paid",
                                    roll:
                                        "${filteredData[internalIndex].rollNumber}",
                                    amount: "${allData?.data?.amount}",
                                    date: todaysDate,
                                    isDone: isDone,
                                    studenId:
                                        "${filteredData[internalIndex].id}",
                                    documentId: "${allData?.data?.id}",
                                    getDataForRefresh: () {
                                      getData();
                                    },
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                  ),
                );
              })),
            ),
          ],
        ),
      ),
    );
  }
}
