import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/views/section_characters_view/section_characters_viewmodel.dart';

import '../../models/episode_model.dart';
import '../../widget/appbar_widget.dart';
import '../../widget/character_card_listview.dart';


class SectionCharactersView extends StatefulWidget {
  final EpisodeModel episodeModel;
  const SectionCharactersView({super.key, required this.episodeModel});

  @override
  State<SectionCharactersView> createState() => _SectionCharactersViewState();
}

class _SectionCharactersViewState extends State<SectionCharactersView> {
  @override
  void initState() {
    super.initState();
    context
        .read<SectionCharactersViewmodel>()
        .getCharacters(widget.episodeModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.episodeModel.episode),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Consumer<SectionCharactersViewmodel>(
              builder: (context, viewModel, child) {
                return CharacterCardListView(characters: viewModel.characters);
              },
            ),
          ],
        ),
      ),
    );
  }
}