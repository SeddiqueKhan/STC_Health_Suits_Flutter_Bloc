import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class Profile extends ProfileEvent {
  final String phone;
  final String password;

  const Profile({required this.phone, required this.password});
}