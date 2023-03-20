import 'package:animal_crossing_radio/Control/control.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class Birthday extends StatelessWidget with Control{
  @override
  Birthday({
    required this.context,
    super.key
  });

  List<String> days = [];
  List<String> months = [];
  List<String> years = [];
  String currentDay = "1";
  String currentMonth = "1";
  String currentYear = "2001";
  final BuildContext context;

  Future<List<String>> generateDays() async {
    // This method generates a list of days
    for (int i = 1; days.length < 31; i++){
      days.add(i.toString());
    }
    return days;
  }

  Future<List<String>> generateMonths() async {
    // This method generates a list of days
    for (int i = 1; months.length < 12; i++){
      months.add(i.toString());
    }
    return months;
  }

  Future<List<String>> generateYears() async {
    // This method generates a list of days
    for (int i = 1913; years.length < 100; i++){
      years.add(i.toString());
    }
    return years;
  }

  daysDialog(List<String> years){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
                scrollable: true,
                content: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: ListView.builder(
                                itemCount: days.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            currentDay = days[index];
                                            Navigator.pop(context, currentDay);
                                          },
                                          child: SizedBox(
                                            width: 200,
                                            height: 100,
                                            child: Card(
                                                child: Row(
                                                  children: [
                                                    const Spacer(),
                                                    Text(years[index],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 25),
                                                      textAlign: TextAlign
                                                          .center,),
                                                    const Spacer(),
                                                  ],
                                                )
                                            ),
                                          )
                                      ),
                                    ],
                                  );
                                },
                              )
                          )
                        ]
                    )
                )
            );
        }
    ).then((value) {
      return currentDay;
    });
  }

  monthsDialog(List<String> years){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
                return AlertDialog(
                scrollable: true,
                content: SizedBox(
                    width : double.maxFinite,
                    height : double.maxFinite,
                    child : Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                              width : double.maxFinite,
                              height : double.maxFinite,
                              child : ListView.builder(
                                itemCount: months.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                          onTap : (){
                                            currentMonth = months[index];
                                            Navigator.pop(context);
                                          },
                                          child : SizedBox(
                                            width: 200,
                                            height: 100,
                                            child: Card(
                                                child: Row(
                                                  children: [
                                                    const Spacer(),
                                                    Text(years[index], style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 25), textAlign: TextAlign.center,),
                                                    const Spacer(),
                                                  ],
                                                )
                                            ),
                                          )
                                      ),
                                    ],
                                  );
                                },
                              )
                          ),
                          const Spacer(),
                        ]
                    )
                )
            );
        }
    ).then((value) {
      return currentMonth;
    });
  }

  yearsDialog(List<String> years){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
                scrollable: true,
                content: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: ListView.builder(
                                itemCount: years.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            currentYear = years[index];
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            width: 200,
                                            height: 100,
                                            child: Card(
                                                child: Row(
                                                  children: [
                                                    const Spacer(),
                                                    Text(years[index],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 25),
                                                      textAlign: TextAlign
                                                          .center,),
                                                    const Spacer(),
                                                  ],
                                                )
                                            ),
                                          )
                                      ),
                                    ],
                                  );
                                },
                              )
                          ),
                          const Spacer(),
                        ]
                    )
                )
            );
  }
  ).then((value) {
    return currentYear;
    });
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
                width: 100,
                height: 50,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  child: InkWell(
                    onTap: () async {
                      days = await generateDays();
                      currentDay = await daysDialog(days);
                      hotReload(context);
                    },
                    child: Card(
                      color: Colors.white,
                      child: Text(
                        currentDay, style: const TextStyle(color: Colors.black,
                          fontSize: 20), textAlign: TextAlign.center,),
                    ),
                  ),
                ),
              ),
          const SizedBox(width: 2,),
          SizedBox(
              width: 100,
              height: 50,
              child: ClipRRect(
                child : InkWell(
                  onTap: () async {
                    months = await  generateMonths();
                    currentMonth = await monthsDialog(months);
                    hotReload(context);
                  },
                  child : Card(
                    color: Colors.white,
                    child: Text(currentMonth, style: const  TextStyle(color: Colors.black, fontSize: 20 ), textAlign: TextAlign.center,) ,
                  ),
                ),
              )
          ),
          const SizedBox(width: 2,),
          SizedBox(
              width: 100,
              height: 50,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child : InkWell(
                  onTap: () async {
                    years = await generateYears();
                    currentYear = await yearsDialog(years);
                    hotReload(context);
                  },
                  child : Card(
                    color: Colors.white,
                    child: Text(currentYear, style: const  TextStyle(color: Colors.black, fontSize: 20 ), textAlign: TextAlign.center,) ,
                  ),
                ),
              )
          ),
          const Spacer(),
        ],
      ),
    );
  }


}