part of 'note_bloc.dart';

class NoteState extends Equatable {
  final Note note;

  const NoteState({required this.note});

  NoteState copyWith({Note? note}) {
    return NoteState(note: note ?? this.note);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [note];
}
