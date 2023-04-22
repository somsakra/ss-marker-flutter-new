part of 'note_bloc.dart';

class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoteEventGetAllNote extends NoteEvent {}

class NoteEventDeleteNote extends NoteEvent {
  final String id;

  const NoteEventDeleteNote({required this.id});
}

class NoteEventAddNewNote extends NoteEvent {
  final NoteElement createdNote;

  const NoteEventAddNewNote({required this.createdNote});
}
