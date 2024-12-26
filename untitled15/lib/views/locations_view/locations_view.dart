import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/appbar_widget.dart';
import '../../widget/decorated_container.dart';
import 'location_listview.dart';
import 'location_viewmodel.dart';


class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    super.initState();
    context.read<LocationViewmodel>().getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppBarWidget(
          title: 'Konumlar',
          transparentBackground: true,
        ),
        body: DecoratedContainer(
          topChild: const SizedBox(height: 74),
          child: _locationListView(),
        ),
      ),
    );
  }

  Widget _locationListView() {
    return Consumer<LocationViewmodel>(
      builder: (context, viewModel, child) {
        if (viewModel.locationModel == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: LocationListView(
              locationModel: viewModel.locationModel!,
              onLoadMore: viewModel.getMoreLocation,
              loadMore: viewModel.loadMore,
            ),
          );
        }
      },
    );
  }
}