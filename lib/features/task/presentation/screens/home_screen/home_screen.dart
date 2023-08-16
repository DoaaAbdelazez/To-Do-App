import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/utils/widgets/custom_button.dart';
import 'package:to_do_app/core/utils/widgets/custom_text_button.dart';

import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //date now
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            //today
            Text(AppStrings.toDay,
                style: Theme.of(context).textTheme.displayLarge),

            //DAte picker
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColors.primary,
              selectedTextColor: AppColors.white,
              dateTextStyle: Theme.of(context).textTheme.displayMedium!,
              dayTextStyle: Theme.of(context).textTheme.displayMedium!,
              monthTextStyle: Theme.of(context).textTheme.displayMedium!,
              onDateChange: (date) {
                // New date selected
                // setState(() {
                //   _selectedValue = date;
                // });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            //no tasks
            // noTasksWidget(context),
            // Text(AppStrings.noTaskSubTitle,
            //     style: Theme.of(context).textTheme.displayMedium),

            InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          height: 240,
                          color: AppColors.deepGrey,
                          child: Column(
                            children: [
                              //task Completed
                              SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: CustomButton(
                                    text: AppStrings.taskCompleted,
                                    onPressed: () {},),
                              ),
                                                            const SizedBox(height:24),

                              //deletTask
                              SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: CustomButton(
                                    text: AppStrings.deletTask,
                                    backgroundColor: AppColors.red,
                                    onPressed: () {},),
                              ),
                              const SizedBox(height:24),
                              //cancle
                              SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: CustomButton(
                                    text: AppStrings.cancle,
                                    onPressed: () {},),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const taskComponent()),
          ],
        ),
      ),
      //FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate(context: context, screen:  AddTaskScreen());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Column noTasksWidget(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.noTasks),
        Text(
          AppStrings.noTaskTitle,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 24,
              ),
        ),
      ],
    );
  }
}

class taskComponent extends StatelessWidget {
  const taskComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          //column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //text
                Text(
                  'Task 1',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                //row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.timer,
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '09:33 PM - 09:48 PM',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                //text
                Text(
                  'Learn Dart',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          //divider
          Container(
            height: 75,
            width: 1,
            color: Colors.white,
            margin: const EdgeInsets.only(right: 10),
          ),
          //text
          RotatedBox(
              quarterTurns: 3,
              child: Text(
                AppStrings.toDo,
                style: Theme.of(context).textTheme.displayMedium,
              )),
        ],
      ),
    );
  }
}
