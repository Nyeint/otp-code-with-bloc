import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable{
  const OtpEvent();
  @override
  List<Object> get props=>[];
}

class OtpStarted extends OtpEvent {}

class FetchOtp extends OtpEvent {}