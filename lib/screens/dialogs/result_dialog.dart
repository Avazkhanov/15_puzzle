import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it_example/screens/puzzle/puzzle_controller.dart';

var controller = Get.find<PuzzleController>();

void showResultDialog({
  required int moves,
  required int timeInSeconds,
}) {
  Get.defaultDialog(
    title: 'Congratulations!',
    backgroundColor: Colors.grey.shade800,
    titleStyle: TextStyle(
      color: Colors.orange,
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You solved the puzzle in ${controller.getMinutelyText(timeInSeconds)} with $moves moves.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          controller.isTrue = true;
          controller.timer();
          controller.tiles.shuffle();
          Get.back();
          Get.back(); // Close the dialog
        },
        child: Text(
          'Play Again',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
