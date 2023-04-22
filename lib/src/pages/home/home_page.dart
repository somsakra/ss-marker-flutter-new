import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marker/src/bloc/note_bloc/note_bloc.dart';
import 'package:marker/src/config/route.dart' as custom_route;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marker/src/constants/setting.dart';
import 'package:marker/src/models/note_content_model.dart';
import 'package:marker/src/models/note_model.dart';
import 'package:marker/src/services/network_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late NoteContent _noteContent;
  String _email = '';

  @override
  void initState() {
    _noteContent = NoteContent(title: "", content: "");
    context.read<NoteBloc>().add(NoteEventGetAllNote());
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        _email = pref.getString(Setting.email) ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_email.split('@')[0]),
        actions: [
          IconButton(
            icon: const FaIcon(Icons.logout),
            onPressed: () {
              SharedPreferences.getInstance().then((pref) {
                pref.remove(Setting.token);
                pref.remove(Setting.email);
                Navigator.pushNamedAndRemoveUntil(
                    context, custom_route.Route.login, (route) => false);
              });
            },
          )
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          List<NoteElement> notes = state.note.notes;
          return RefreshIndicator(
              onRefresh: () async {
                context.read<NoteBloc>().add(NoteEventGetAllNote());
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  ...notes.map((note) => _buildNote(
                      id: note.id, title: note.title, content: note.content)),
                  const SizedBox(height: 150),
                ]),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 600,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: _form,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    onSaved: (String? value) {
                                      _noteContent.title =
                                          value!.isEmpty ? " " : value;
                                    },
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                    decoration: const InputDecoration(
                                        hintText: 'Title',
                                        hintStyle: (TextStyle(
                                            color: Colors.black54)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    onSaved: (String? value) {
                                      _noteContent.content =
                                          value!.isEmpty ? " " : value;
                                    },
                                    minLines: 1,
                                    maxLines: 5,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    decoration: const InputDecoration(
                                        hintText: 'Content',
                                        hintStyle: (TextStyle(
                                            color: Colors.black54)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FloatingActionButton(
                                child: const Icon(Icons.add),
                                onPressed: () async {
                                  _form.currentState?.save();
                                  var result = await NetworkService()
                                      .noteAddNewNote(_noteContent);
                                  NoteElement createdNote = result.createdNote;
                                  if (!mounted) return;
                                  context.read<NoteBloc>().add(
                                      NoteEventAddNewNote(
                                          createdNote: createdNote));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Center _buildNote(
      {required String id, required String title, required String content}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          color: Colors.black12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, bottom: 10, top: 10),
                child: Text(
                  content,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 32,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          await NetworkService().noteDeleteNote(id);
                          if (!mounted) return;
                          context
                              .read<NoteBloc>()
                              .add(NoteEventDeleteNote(id: id));
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.blueGrey,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
