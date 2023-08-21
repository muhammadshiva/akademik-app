import 'package:akademik_app/data/model/dosen/dosen_model.dart';
import 'package:akademik_app/data/repositories/dosen_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_dosen_event.dart';
part 'fetch_dosen_state.dart';

class FetchDosenBloc extends Bloc<FetchDosenEvent, FetchDosenState> {
  FetchDosenBloc() : super(FetchDosenInitial()) {
    on<FetchDosenEvent>((event, emit) async {
      if (event is FetchDosen) {
        try {
          emit(FetchDosenLoading());

          final data = await DosenRepository().fetchDosen();

          emit(FetchDosenSuccess(data));
        } catch (e) {
          emit(FetchDosenFailed(e.toString()));
        }
      }
    });
  }
}
