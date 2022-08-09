import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'main_management_page_state.dart';

class MainManagementPageCubit extends Cubit<MainManagementPageState> {
  MainManagementPageCubit() : super(MainManagementPageInitialState());

  Future<void> informInitial() async {
    if (kDebugMode) {
      print("Main page is loading");
    }
  }

  Future<void> loadMainManagementPage() async {
    try{ // for future DB requests
      if (isClosed == false) {
        emit(MainManagementPageLoadedState());
        if (kDebugMode) {
          print("Main page is loaded");
        }}
    }catch (e) {
      if (isClosed == false) {
        emit(MainManagementPageErrorState());
        if (kDebugMode) {
          print("Failed to load Main page");
        }
      }
    }
  }

    Future<void> reloadMainManagementPage() async {
      if (isClosed == false){
        emit(MainManagementPageInitialState());
      }
    }
  }

