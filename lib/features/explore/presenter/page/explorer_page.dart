import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/components/custom_bottom_appbar.dart';
import 'package:sp_pontos/core/components/image.dart';
import 'package:sp_pontos/core/providers/photo_provider.dart';
import 'package:sp_pontos/features/explore/presenter/components/actions.dart';
import 'package:sp_pontos/features/explore/presenter/components/infos_photo.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  void _fetchPhotos() async {
    await Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoProvider>(
      builder: (context, photoProvider, child) {
        return Scaffold(
          body: photoProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : photoProvider.photos.isEmpty
                  ? const Center(child: Text('Nenhuma foto encontrada.'))
                  : PageView.builder(
                    clipBehavior:Clip.antiAlias,
                      itemCount: photoProvider.photos.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final photo = photoProvider.photos[index];
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors
                              .black, // Fundo preto para evitar transparência
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ImageComponent(
                                imageUrl: photo.photoUrl,
                                height: double.infinity,
                              ),
                              Positioned(
                                bottom: 40,
                                left: 20,
                                child: 
                                  InfosPhoto(
                                    title: photo.location ??
                                        'Localização desconhecida',
                                    
                                ),
                              ),
                              Positioned(
                                width: 60,
                                height: 60,
                                right: 20,
                                bottom: 140,
                                child: ActionsComponent(
                                  photoId: photo.photoId,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          extendBody: false,
          bottomNavigationBar: const CustomBottomAppBar(),
        );
      },
    );
  }
}
