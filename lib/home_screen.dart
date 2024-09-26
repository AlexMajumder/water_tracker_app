import 'package:flutter/material.dart';
import 'package:water_tracker/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController =
      TextEditingController(text: '1');

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            _buildWaterTrackCounter(),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: _buildWaterTrackListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
        itemBuilder: (context, index) {
          return _buildWaterTrackListTile( index);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        );
  }

  Widget _buildWaterTrackListTile(int index) {
    WaterTrack waterTrack = waterTrackList[index];
    return ListTile(
          title: Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
          subtitle: Text('${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
          leading: CircleAvatar(child: Text('${waterTrack.glassesOfWater}')),
          trailing: IconButton(
            onPressed: () => _onTapDeleteButton(index),
            icon: Icon(Icons.delete),
          ),
        );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const Text(
          'Glass/es',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                controller: _glassNoTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: _onTapAddWaterTrack,
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.glassesOfWater; // its called 'noOfGlasses'
    }
    return counter;
  }

  void _onTapAddWaterTrack() {
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = '1';
    }

    final int glassesOfWater = int.tryParse(_glassNoTEController.text) ?? 1;

    WaterTrack waterTrack = WaterTrack(
      glassesOfWater: glassesOfWater,
      dateTime: DateTime.now(),
    );
    waterTrackList.add(waterTrack);
    setState(() {});
  }

  void _onTapDeleteButton( int index){
    waterTrackList.removeAt(index);
    setState(() {});
  }

}
