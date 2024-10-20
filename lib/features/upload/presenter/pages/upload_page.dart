import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/providers/tourist_attraction_provider.dart';
import 'package:sp_pontos/core/services/upload_service.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? _selectedLocation;
  bool _isLoading = false;
  File? _imageFile;
  final UploadService _uploadService = UploadService();

  @override
  void initState() {
    super.initState();
    Provider.of<TouristAttractionProvider>(context, listen: false)
        .fetchTouristAttractions();
  }

  @override
  Widget build(BuildContext context) {
    final attractionProvider = Provider.of<TouristAttractionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Imagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _imageFile != null
                ? Expanded(
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'Nenhuma imagem selecionada',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ),
            const SizedBox(height: 16),

            // Dropdown to show locations
            attractionProvider.isLoading
                ? CircularProgressIndicator()
                : DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    hint: const Text('Selecione o Local'),
                    items: attractionProvider.places.map((place) {
                      return DropdownMenuItem<String>(
                        value: place.id,
                        child: Text(
                          place.name,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => buildBottomSheet(context),
              ),
              child: const Text('Selecionar Imagem'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _imageFile != null && _selectedLocation != null && !_isLoading
                      ? () => _uploadImage(context)
                      : null,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Concluir'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final imageUrl = await _uploadService.uploadImage(_imageFile!);
      await _uploadService.savePhotoDetails(imageUrl, _selectedLocation!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagem enviada com sucesso!')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Widget buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt_outlined),
          title: const Text('Abrir câmera'),
          onTap: () {
            Navigator.pop(context);
            pickImage(ImageSource.camera, context);
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_library_outlined),
          title: const Text('Selecionar da galeria'),
          onTap: () {
            Navigator.pop(context);
            pickImage(ImageSource.gallery, context);
          },
        ),
      ],
    );
  }
}
