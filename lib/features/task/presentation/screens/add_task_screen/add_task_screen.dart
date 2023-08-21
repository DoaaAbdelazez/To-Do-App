import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/utils/widgets/custom_button.dart';
import 'package:to_do_app/core/utils/widgets/custom_text_button.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../../components/add_task-component.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is InsertTaskSucessState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<TaskCubit>(context);
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! title
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).titleController,
                      title: AppStrings.title,
                      hintText: AppStrings.titleHint,
                      validator: (val){
                        if(val!.isEmpty){
                          return AppStrings.tittleErrorMs;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //! note
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).noteController,
                      title: AppStrings.note,
                      hintText: AppStrings.noteHint,
                      validator: (val){
                        if(val!.isEmpty){
                          return AppStrings.noteErrorMs;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //! date
                    AddTaskComponent(
                      readOnly: true,
                      title: AppStrings.date,
                      hintText: DateFormat.yMd().format(
                          BlocProvider.of<TaskCubit>(context).currentdate),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          BlocProvider.of<TaskCubit>(context).getDate(context);
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //! start-End time
                    Row(
                      children: [
                        //start
                        Expanded(
                          child: AddTaskComponent(
                            readOnly: true,
                            title: AppStrings.startTime,
                            hintText:
                                BlocProvider.of<TaskCubit>(context).startTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getStartTime(context);
                              },
                              icon: const Icon(Icons.timer_outlined),
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        //End
                        Expanded(
                          child: AddTaskComponent(
                            readOnly: true,
                            title: AppStrings.endTime,
                            hintText:
                                BlocProvider.of<TaskCubit>(context).endTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getEndtTime(context);
                              },
                              icon: const Icon(Icons.timer_outlined),
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //!color
                    SizedBox(
                      height: 68.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //color
                          Text(
                            AppStrings.color,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<TaskCubit>(context)
                                            .changeCheckMarkIndex(index);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            BlocProvider.of<TaskCubit>(context)
                                                .getColor(index),
                                        child: index ==
                                                BlocProvider.of<TaskCubit>(
                                                        context)
                                                    .currentIndex
                                            ? const Icon(Icons.check)
                                            : null,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //! add task button
                    SizedBox(
                      height: 92.h,
                    ),
                    state is InsertTaskLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ))
                        : SizedBox(
                            height: 48.h,
                            width: double.infinity,
                            child: CustomButton(
                                text: AppStrings.creatTask,
                                onPressed: () {
                                  if (BlocProvider.of<TaskCubit>(context)
                                      .formkey
                                      .currentState!
                                      .validate()) {
                                    BlocProvider.of<TaskCubit>(context)
                                        .insertTask();
                                  }
                                }),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AddTaskComponent pickDate(BuildContext context) {
    return AddTaskComponent(
      title: AppStrings.date,
      hintText: DateFormat.yMd()
          .format(BlocProvider.of<TaskCubit>(context).currentdate),
      suffixIcon: IconButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025),
            );
            // setState(() {
            //   if (pickedDate != null) {
            //     currentdate = pickedDate;
            //   } else {
            //     print('pickedDate == null');
            //   }
            // });
          },
          icon: const Icon(
            Icons.calendar_month_rounded,
            color: AppColors.white,
          )),
      readOnly: true,
    );
  }
}
