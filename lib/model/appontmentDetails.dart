import 'package:meta/meta.dart';

class AppointmentDetails {
  final String appointmentId;
  final String callerId;
  final bool status;
  final String patientName;

  const AppointmentDetails({
    required this.appointmentId,
    required this.callerId,
    required this.status,
    required this.patientName,
  });

  AppointmentDetails copy(
          {String? appointmentId,
          String? callerId,
          bool? status,
          String? patientName}) =>
      AppointmentDetails(
        appointmentId: appointmentId ?? this.appointmentId,
        callerId: callerId ?? this.callerId,
        status: status ?? this.status,
        patientName: patientName ?? this.patientName,
      );
}
