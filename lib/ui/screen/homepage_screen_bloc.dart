import 'package:akademik_app/data/bloc/fetch_dosen/fetch_dosen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageScreenBloc extends StatefulWidget {
  const HomePageScreenBloc({super.key});

  @override
  State<HomePageScreenBloc> createState() => _HomePageScreenBlocState();
}

class _HomePageScreenBlocState extends State<HomePageScreenBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage Screen Bloc'),
      ),
      body: BlocProvider(
        create: (context) => FetchDosenBloc()..add(FetchDosen()),
        child: BlocBuilder<FetchDosenBloc, FetchDosenState>(
          builder: (context, state) {
            if (state is FetchDosenFailed) {
              print(state.e);
            } else if (state is FetchDosenSuccess) {
              return ListView.builder(
                itemCount: state.dosen.length,
                itemBuilder: (context, index) {
                  var data = state.dosen[index];
                  return Text(data.nama);
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
