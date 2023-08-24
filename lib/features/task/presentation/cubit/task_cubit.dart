import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/database/cache/cache_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../../../../core/utils/app_colors.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  DateTime currentdate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //get Date from user
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      currentdate = pickedDate;
      emit(GetDateSucessState());
    } else {
      print('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetStartTimeSucessState());
    } else {
      print('pickedStartTime==null');
      emit(GetStartTimeErrorState());
    }
  }

  void getEndtTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedendTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ),
    );
    if (pickedendTime != null) {
      endTime = pickedendTime.format(context);
      emit(GetEndTimeSucessState());
    } else {
      print('pickedEndTime==null');
      emit(GetEndTimeErrorState());
    }
  }

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void changeCheckMarkIndex(index) {
    emit(ChangeCheckMarkIndexState());
    currentIndex = index;
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;

    emit(GetSelectedDateSucessState());
    getTasks();
  }

  List<TaskModel> tasksList = [];
  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await sl<SqfliteHelper>().insertToDB(
        TaskModel(
          date: DateFormat.yMd().format(currentdate),
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          isCompleted: 0,
          color: currentIndex,
        ),
      );
      getTasks();
      titleController.clear();
      noteController.clear();
      emit(InsertTaskSucessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

//!get Tasks
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(selectedDate),
          )
          .toList();
      emit(GetDateSucessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }

//update Task
  void updateTask(id) async {
    emit(UpdateTaskLoadingState());

    await sl<SqfliteHelper>().updatedDB(id).then((value) {
      emit(UpdateTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

//delete task
  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());

    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }
  bool isDark = false;

  void changeTheme() async {
    isDark = !isDark;
    await sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }

  void getTheme()async{
  isDark =await sl<CacheHelper>().getData(key: 'isDark');
  emit(GetThemeState());
}

}
