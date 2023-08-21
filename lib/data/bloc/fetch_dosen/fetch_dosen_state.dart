part of 'fetch_dosen_bloc.dart';

@immutable
abstract class FetchDosenState {}

class FetchDosenInitial extends FetchDosenState {}

class FetchDosenLoading extends FetchDosenState {}

class FetchDosenFailed extends FetchDosenState {
  final String e;
  FetchDosenFailed(this.e);
}

class FetchDosenSuccess extends FetchDosenState {
  final List<DosenModel> dosen;
  FetchDosenSuccess(this.dosen);
}
