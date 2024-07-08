import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/customAddIcon.dart';
import 'package:myfitness/components/customSubIcon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Method to read JSON from assets
Future<Map<String, dynamic>> loadJson(String fileName) async {
  final String response =
      await rootBundle.loadString('lib/json files/$fileName');
  return json.decode(response);
}

// Custom widget for Water Intake
class WaterIntake extends StatelessWidget {
  final int value;
  final int max;

  WaterIntake({required this.value, this.max = 7});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(max, (index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: index >= max - value
                ? Color.fromRGBO(21, 109, 149, 1)
                : Color.fromRGBO(217, 217, 217, 1),
          ),
          margin: EdgeInsets.symmetric(vertical: 2.0.h),
          height: index == max - max ? 11.h : 8.h,
          width: index == max - max ? 25.w : 50.w, // Topmost line smaller width
        );
      }),
    );
  }
}

// Custom widget for Steps Walked
class StepsWalked extends StatelessWidget {
  final int value;
  final int max;

  StepsWalked({required this.value, this.max = 10000});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 80.h,
              width: 80.h,
              child: CircularProgressIndicator(
                value: value / max,
                strokeCap: StrokeCap.round,
                backgroundColor: Color.fromRGBO(204, 204, 204, 1),
                color: Color.fromRGBO(21, 109, 149, 1),
                strokeWidth: 12,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter'),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(" "),
        Text(
          'Steps Walked',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter'),
        ),
      ],
    );
  }
}

// Main Component Screen
class HealthTrackerComponent extends StatefulWidget {
  @override
  _HealthTrackerComponentState createState() => _HealthTrackerComponentState();
}

class _HealthTrackerComponentState extends State<HealthTrackerComponent> {
  int waterIntake = 0;
  int stepsWalked = 0;
  String waterIntakeTitle = "";
  String stepsWalkedTitle = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Method to load data from JSON files
  Future<void> loadData() async {
    final waterData = await loadJson('waterIntake.json');
    final stepsData = await loadJson('steps.json');

    setState(() {
      waterIntake = waterData['value'];
      waterIntakeTitle = waterData['title'];
      stepsWalked = stepsData['value'];
      stepsWalkedTitle = stepsData['title'];
    });
  }

  // Method to increment water intake
  void incrementWater() {
    setState(() {
      if (waterIntake < 7) {
        waterIntake++;
      }
    });
  }

  // Method to decrement water intake
  void decrementWater() {
    setState(() {
      if (waterIntake > 0) {
        waterIntake--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CustomSubIcon(
                        onPressed: decrementWater,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        children: [
                          WaterIntake(value: waterIntake),
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      CustomIconButton(
                        onPressed: incrementWater,
                      ),
                    ],
                  ),
                  Text(
                    '${waterIntake * 8} oz',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter'),
                  ),
                  Text(
                    "Daily Water Intake",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                ],
              ),
              SizedBox(
                  width: 60
                      .w), // Increased space between water and steps indicators
              Column(
                children: [
                  StepsWalked(value: stepsWalked),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
