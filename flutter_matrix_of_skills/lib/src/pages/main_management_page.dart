import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_management_page_cubit.dart';

// ignore: must_be_immutable
class MainManagementPage extends StatelessWidget {
  const MainManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainManagementPageCubit(),
      child: const _MainManagementPage(),
    );
  }
}
  class _MainManagementPage extends StatelessWidget {
    const _MainManagementPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(builder: (context, state) {
        if(state is MainManagementPageInitialState){
          context.read<MainManagementPageCubit>().informInitial();
          context.read<MainManagementPageCubit>().loadMainManagementPage();
          return Scaffold(
              backgroundColor: Colors.blueAccent,
              appBar: AppBar(
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)]))),
                title: Text("Page is loading..",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.pink.shade200
                            .withOpacity(0.25),
                        offset: const Offset(7, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.purple,
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)])),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          );
        }

        if(state is MainManagementPageLoadedState){
          return Scaffold(
              backgroundColor: Colors.blueAccent,
              appBar: AppBar(
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)]))),
                title: Text("Page is loading..",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.pink.shade200
                            .withOpacity(0.25),
                        offset: const Offset(7, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.purple,
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)])),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () => print("Tapped"),
                      child: Container(
                        color: Colors.brown,
                      )
                  ),
                ),
              )
          );
        }
       if(state is MainManagementPageErrorState) {
          return Scaffold(
              backgroundColor: Colors.blueAccent,
              appBar: AppBar(
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)]))),
                title: Text("Page is loading..",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.pink.shade200
                            .withOpacity(0.25),
                        offset: const Offset(7, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.purple,
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)])),
                child: const Center(
                  child: Text("Err"),
                ),
              )
          );
       }
       return Container();
      }
    );
  }
}