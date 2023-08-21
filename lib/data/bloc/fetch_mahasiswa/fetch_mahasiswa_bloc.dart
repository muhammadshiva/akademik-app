import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_mahasiswa_event.dart';
part 'fetch_mahasiswa_state.dart';

class FetchMahasiswaBloc extends Bloc<FetchMahasiswaEvent, FetchMahasiswaState> {
  FetchMahasiswaBloc() : super(FetchMahasiswaInitial()) {
    on<FetchMahasiswaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
