import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it_example/screens/dialogs/result_dialog.dart';
import 'package:get_it_example/screens/puzzle/puzzle_controller.dart';
import 'package:get_it_example/screens/records/records_screen.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  final PuzzleController controller = Get.put(PuzzleController());

  @override
  void initState() {
    controller.timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (!controller.isGame) {
              controller.isTrue = true;
              controller.timer();
              controller.tiles.shuffle();
              controller.datetime.value = 0;
              Get.back();
            }
          },
          icon: Icon(
            Icons.shuffle,
            size: 30.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "15 PUZZLE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (!controller.isGame) {
                Get.to(const RecordsScreen());
              }
            },
            icon: Icon(
              Icons.history,
              size: 30.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.r)
                ),
                color: Colors.grey.shade900,
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 20.h,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MOVES",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        controller.counter.toString(),
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TIME",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        controller.getMinutelyText(controller.datetime.value),
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 400.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey.shade900,
              ),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 30.h),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.moveTile(index);
                      if (controller.isSorted()) {
                        showResultDialog(
                            moves: controller.counter.value,
                            timeInSeconds: controller.datetime.value);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: controller.tiles[index] == 15
                            ? Colors.transparent
                            : Colors.orange,
                      ),
                      margin: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '${controller.tiles[index] == 15 ? '' : controller.tiles[index] + 1}',
                          style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
