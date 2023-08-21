
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class GetDateLoadingState extends TaskState {}

final class GetDateSucessState extends TaskState {}

final class GetDateErrorState extends TaskState {}

final class GetStartTimeLoadingState extends TaskState {}

final class GetStartTimeSucessState extends TaskState {}

final class GetStartTimeErrorState extends TaskState {}

final class GetEndTimeLoadingState extends TaskState {}

final class GetEndTimeSucessState extends TaskState {}

final class GetEndTimeErrorState extends TaskState {}

final class ChangeCheckMarkIndexState extends TaskState {}

final class InsertTaskLoadingState extends TaskState {}

final class InsertTaskSucessState extends TaskState {}

final class InsertTaskErrorState extends TaskState {}
final class GetTaskLoadingState extends TaskState {}

final class GetTaskSucessState extends TaskState {}

final class GetTaskErrorState extends TaskState {}
