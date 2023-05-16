import 'package:equatable/equatable.dart';
import 'package:otp_code/models/data_model.dart';

abstract class OtpState extends Equatable{
  OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitialized extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  DataModel dataModel;
  OtpSuccess({required this.dataModel});
}

class OtpError extends OtpState {
  final String errorMessage;
  OtpError({required this.errorMessage});
}