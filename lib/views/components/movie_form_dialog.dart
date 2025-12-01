import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/viewmodels/movie_view_model.dart';
import 'package:movie/views/components/custom_text_fields.dart';
import 'package:provider/provider.dart';

class MovieFormDialog extends StatefulWidget {
  final Movie? movie;
  const MovieFormDialog({super.key, this.movie});

  @override
  State<MovieFormDialog> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MovieFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _durationController;
  late TextEditingController _plotController;
  late TextEditingController _yearController;
  @override
  void initstate() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie?.title ?? '');
    _plotController = TextEditingController(text: widget.movie?.plot ?? '');
    _durationController = TextEditingController(
      text: widget.movie?.duration.toString() ?? '',
    );
    _yearController = TextEditingController(
      text: widget.movie?.year.toString() ?? '',
    );

    @override
    void dispose() {
      _titleController.dispose();
      _durationController.dispose();
      _plotController.dispose();
      _yearController.dispose();
      super.dispose();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newMovie = Movie(
        title: _titleController.text,
        duration: int.parse(_durationController.text),
        plot: _plotController.text,
        year: int.parse(_yearController.text),
      );

      final vm = context.read<MovieViewModel>();
      if (widget.movie == null) {
        vm.addMovie(newMovie);
      } else {
        vm.updateMovie(newMovie);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.movie == null ? 'Aggiungi film' : "modifica film"),
      content: SingleChildScrollView(
        key: _formKey,
        child: Form(
          child: Column(
            children: [
              CustomTextFields(
                controller: _titleController,
                label: "Titolo",
                keyboardType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? "campo obbligatorio"
                    : null,
              ),
              CustomTextFields(
                controller: _durationController,
                label: "Durata in minuti",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || int.tryParse(value) == null
                    ? "inserisci un numero"
                    : null,
              ),
              CustomTextFields(
                controller: _plotController,
                label: "Trama",
                keyboardType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? "campo obbligatorio"
                    : null,
              ),
              CustomTextFields(
                controller: _yearController,
                label: "Anno di uscita",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || int.tryParse(value) == null
                    ? "inserisci un numero"
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Annulla"),
        ),
        ElevatedButton(onPressed: _submitForm, child: const Text("Salva")),
      ],
    );
  }
}
