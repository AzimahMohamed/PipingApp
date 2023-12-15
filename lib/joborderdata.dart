class JobOrder {

  int id;
  int project_id;
  int jo_number;
  int bq_road_id;
  int pipe_job_type;
  DateTime jo_date;
  int status;

  JobOrder({this.id, this.project_id, this.jo_number, this.bq_road_id, this.pipe_job_type, this.jo_date, this.status});

  factory JobOrder.fromJson(Map<String, dynamic> json) {
    return JobOrder(
      id: json["id"] as int,
      project_id:  json["project_id"] as int,
      jo_number: json["jo_number"] as int,
      bq_road_id: json["bq_road_id"] as int,
      pipe_job_type: json["pipe_job_type"] as int,
      jo_date: json["jo_date"] as DateTime,
      status: json["status"] as int,
    );
  }

}