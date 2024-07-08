import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/checkBox.dart';

class Frame extends StatefulWidget {
  final String? image;
  final String name;
  final String text;
  final String? subtitle;
  final bool many;
  final bool isSelected;
  final bool showCheckbox;
  final ValueChanged<bool>? onChanged;
  final int? maxSelections;
  final int currentSelections;

  const Frame({
    this.image,
    required this.name,
    required this.text,
    this.subtitle,
    required this.many,
    this.isSelected = false,
    this.showCheckbox = false,
    this.onChanged,
    this.maxSelections,
    required this.currentSelections,
  });

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isSelected;
  }

  @override
  void didUpdateWidget(Frame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      setState(() {
        isChecked = widget.isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color lightBorderColorUnchecked = Color.fromARGB(28, 0, 0, 0);
    Color lightBorderColorChecked = Color.fromRGBO(93, 166, 199, 1);
    Color darkBorderColorUnchecked = Color.fromRGBO(45, 52, 80, 1);
    List<Color> darkBorderColorCheckedGradient = [
      Color.fromRGBO(90, 200, 250, 0.4),
      Color.fromRGBO(120, 108, 255, 0.5)
    ];

    Brightness brightness = Theme.of(context).brightness;
    bool isDark = brightness == Brightness.dark;

    BoxDecoration decoration;

    if (isDark) {
      if (isChecked) {
        decoration = BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 2.0.w,
          ),
          gradient: LinearGradient(
            colors: darkBorderColorCheckedGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0.r),
        );
      } else {
        decoration = BoxDecoration(
          border: Border.all(
            color: darkBorderColorUnchecked,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(10.0.r),
        );
      }
    } else {
      decoration = BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color:
              isChecked ? lightBorderColorChecked : lightBorderColorUnchecked,
          width: 1.5.w,
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: InkWell(
        onTap: () {
          if (widget.onChanged != null) {
            if (widget.many) {
              if (!isChecked &&
                  (widget.maxSelections == null ||
                      widget.currentSelections < widget.maxSelections!)) {
                setState(() {
                  isChecked = true;
                });
                widget.onChanged!(true);
              } else if (isChecked) {
                setState(() {
                  isChecked = false;
                });
                widget.onChanged!(false);
              }
            } else {
              setState(() {
                isChecked = !isChecked;
              });
              widget.onChanged!(isChecked);
            }
          }
        },
        child: Container(
          height: 88.h,
          width: 340.w,
          decoration: decoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.image != null)
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Container(
                    height: 62.h, // Fixed height of 70
                    width: 60.w, // Adjusted width
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(120, 108, 255, 0.17),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Image.asset(
                      widget.image!,
                      // Ensure the image fits the container
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      if (widget.subtitle != null)
                        Text(
                          widget.subtitle!,
                          style: TextStyle(
                            fontSize: 14.0.sp,
                            fontFamily: 'Inter',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (widget.showCheckbox || widget.many)
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Transform.scale(
                    scale: 1.17,
                    child: CheckBoxWidget(
                      value: isChecked,
                      onChanged: (value) {
                        if (widget.onChanged != null) {
                          if (widget.many) {
                            if (value! &&
                                (widget.maxSelections == null ||
                                    widget.currentSelections <
                                        widget.maxSelections!)) {
                              setState(() {
                                isChecked = value;
                              });
                              widget.onChanged!(true);
                            } else if (!value) {
                              setState(() {
                                isChecked = value;
                              });
                              widget.onChanged!(false);
                            }
                          } else {
                            setState(() {
                              isChecked = value!;
                            });
                            widget.onChanged!(value!);
                          }
                        }
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
