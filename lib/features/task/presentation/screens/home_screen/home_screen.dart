import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/utils/widgets/custom_button.dart';
import 'package:to_do_app/core/utils/widgets/custom_text_button.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //date now
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TaskCubit>(context).changeTheme();
                        },
                        icon: Icon(
                          Icons.mode_night,
                          color: BlocProvider.of<TaskCubit>(context).isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      ),
                    ],
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
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  //no tasks
                  BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                      ? noTasksWidget(context)
                      : Expanded(
                          child: ListView.builder(
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasksList
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
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
                                                BlocProvider.of<TaskCubit>(
                                                                context)
                                                            .tasksList[index]
                                                            .isCompleted ==
                                                        1
                                                    ? Container()
                                                    : SizedBox(
                                                        height: 48,
                                                        width: double.infinity,
                                                        child: CustomButton(
                                                          text: AppStrings
                                                              .taskCompleted,
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        TaskCubit>(
                                                                    context)
                                                                .updateTask(BlocProvider.of<
                                                                            TaskCubit>(
                                                                        context)
                                                                    .tasksList[
                                                                        index]
                                                                    .id);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                const SizedBox(height: 24),

                                                //deletTask
                                                SizedBox(
                                                  height: 48,
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: AppStrings.deletTask,
                                                    backgroundColor:
                                                        AppColors.red,
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  TaskCubit>(
                                                              context)
                                                          .deleteTask(BlocProvider
                                                                  .of<TaskCubit>(
                                                                      context)
                                                              .tasksList[index]
                                                              .id);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                                //cancle
                                                SizedBox(
                                                  height: 48,
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: AppStrings.cancle,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: taskComponent(
                                    taskModel:
                                        BlocProvider.of<TaskCubit>(context)
                                            .tasksList[index],
                                  ));
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ),
        //FAB
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
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
        Text(AppStrings.noTaskSubTitle,
            style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}

class taskComponent extends StatelessWidget {
  const taskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BlocProvider.of<TaskCubit>(context).getColor(taskModel.color),
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
                //tittle
                Text(
                  taskModel.title,
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
                      '${taskModel.startTime} - ${taskModel.endTime}',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                //note
                Text(
                  taskModel.note,
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
                taskModel.isCompleted == 1
                    ? AppStrings.completed
                    : AppStrings.toDo,
                style: Theme.of(context).textTheme.displayMedium,
              )),
        ],
      ),
    );
  }
}
