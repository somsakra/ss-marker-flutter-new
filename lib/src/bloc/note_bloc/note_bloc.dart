import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marker/src/models/note_content_model.dart';
import 'package:marker/src/services/network_services.dart';

import '../../models/note_model.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState(note: Note(count: 0, notes: []))) {
    on<NoteEventGetAllNote>((event, emit) async {
      final result = await NetworkService().noteGetAll();
      Note noteState = noteFromJson(jsonEncode(result));
      emit(state.copyWith(note: noteState));
    });
    on<NoteEventDeleteNote>((event, emit) {
      int count = state.note.count - 1;
      List filteredNotes =
          state.note.notes.where((element) => element.id != event.id).toList();
      Note noteState = Note(count: count, notes: [...filteredNotes]);
      emit(state.copyWith(note: noteState));
    });
    on<NoteEventAddNewNote>((event, emit) {
      Note noteState = Note(
          count: state.note.count + 1,
          notes: [...state.note.notes, event.createdNote]);
      emit(state.copyWith(note: noteState));
    });
  }
}
