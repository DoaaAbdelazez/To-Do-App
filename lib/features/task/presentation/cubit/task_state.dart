
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
final class UpdateTaskLoadingState extends TaskState {}

final class UpdateTaskSucessState extends TaskState {}

final class UpdateTaskErrorState extends TaskState {}
final class DeleteTaskLoadingState extends TaskState {}

final class DeleteTaskSucessState extends TaskState {}

final class DeleteTaskErrorState extends TaskState {}
final class GetSelectedDateLoadingState extends TaskState {}
final class GetSelectedDateSucessState extends TaskState {}

final class ChangeThemeState extends TaskState {}
final class GetThemeState extends TaskState {}


