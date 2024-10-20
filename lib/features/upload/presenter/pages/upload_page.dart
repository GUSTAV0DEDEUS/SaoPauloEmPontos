import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? _selectedLocation;
  bool _isLoading = false;
  File? _imageFile;

  // Simulação de locais disponíveis
  List<String> _locations = ['Local 1', 'Local 2', 'Local 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Imagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Verifica se a imagem foi selecionada e exibe a imagem
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
            // Dropdown para selecionar o local
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              hint: const Text('Selecione o Local'),
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            // Botão para selecionar imagem
            ElevatedButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => buildBottomSheet(context),
              ),
              child: const Text('Selecionar Imagem'),
            ),
            const SizedBox(height: 16),
            // Botão para concluir a ação
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

  // Função para fazer o upload da imagem
  Future<void> _uploadImage(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Nome único para o arquivo no Storage
      final fileName = path.basename(_imageFile!.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      // Enviar o arquivo para o Firebase Storage
      await storageRef.putFile(_imageFile!);

      // Obter o URL da imagem após o upload
      final imageUrl = await storageRef.getDownloadURL();

      // Simulação de atualização do perfil do usuário com o local e a imagem
      print('Imagem carregada com sucesso: $imageUrl');
      print('Local selecionado: $_selectedLocation');

      // Aqui você pode associar o `imageUrl` e o `local` ao perfil do usuário no seu banco de dados

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagem enviada com sucesso!')),
      );

      // Voltar para a tela anterior
      Navigator.of(context).pop();
    } catch (e) {
      print('Erro ao enviar a imagem: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar a imagem')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Função para selecionar imagem (câmera ou galeria)
  Future<void> pickImage(ImageSource source, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });

        // Imprimindo o caminho da imagem
        print('Caminho da imagem selecionada: ${image.path}');
      } else {
        // Lidar com o caso onde nenhuma imagem foi selecionada
        print('Nenhuma imagem foi selecionada');
      }
    } catch (e) {
      print('Erro ao selecionar a imagem: $e');
    }
  }

  // BottomSheet para selecionar imagem da câmera ou galeria
  Widget buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              'Publique uma foto',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
              pickImage(
                ImageSource.gallery,
                context,
              );
            },
          ),
        ],
      ),
    );
  }
}
