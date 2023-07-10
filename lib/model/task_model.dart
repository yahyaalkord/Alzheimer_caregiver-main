

class TaskModel{

  late String taskId;
  late String patientId;
  late String caregiverId;
  late String title;
  late String description;
  late DateTime startDate;
  late int duration;
  late DateTime endDate;
  late String hour;
  late String repeat;
  late bool isActive;


  TaskModel
      (
      {
        required this.patientId,
        required this.taskId,
        required this.caregiverId,
        required this.title,
        required this.description,
        required this.startDate,
        required this.duration,
        required this.endDate,
        required this.repeat,
        required this.hour,
        required this.isActive



      }
      );



  Map<String,dynamic> toMap(){
    return {
      "patientId": patientId,
      'caregiverId':caregiverId,
      "taskId": taskId,
      "startDate": startDate,
      "duration":duration,
      "endDate":endDate,
      "repeat":repeat,
      "title":title,
      "description":description,
      'hour':hour,
      'isActive':isActive


    };
  }
}