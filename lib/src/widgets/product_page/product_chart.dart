import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';

import '../homepage/home_search_bar.dart';

class LinePage extends StatefulWidget {
  final List<double> data;
  const LinePage({Key? key, required this.data}) : super(key: key);

  @override
  State<LinePage> createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 600.0,
          maxWidth: 1000.0,
        ),
        padding: const EdgeInsets.all(24.0),
        child: Chart(
          layers: layers(),
          padding: const EdgeInsets.symmetric(horizontal: 30.0).copyWith(
            bottom: 12.0,
          ),
        ),
      ),
    );
  }

  List<ChartLayer> layers() {
    return [
      ChartHighlightLayer(
        shape: () => ChartHighlightLineShape<ChartLineDataItem>(
          backgroundColor: boxcolor,
          currentPos: (item) => item.currentValuePos,
          radius: const BorderRadius.all(Radius.circular(8.0)),
          width: 60.0,
        ),
      ),
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: 1,
            max: widget.data.length.toDouble() - 1,
            min: 0,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency:
                (widget.data.reduce(max) - widget.data.reduce(min)).abs() / 2,
            max: widget.data.reduce(max),
            min: widget.data.reduce(min),
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => "d-${(widget.data.length - value).toInt()}",
        labelY: (value) => value.toInt().toString(),
      ),
      ChartLineLayer(
        items: List.generate(
          widget.data.length,
          (index) => ChartLineDataItem(
            x: index.toDouble(),
            value: widget.data[index],
          ),
        ),
        settings: const ChartLineSettings(
          color: textcolor,
          thickness: 4.0,
        ),
      ),
      ChartTooltipLayer(
        shape: () => ChartTooltipLineShape<ChartLineDataItem>(
          backgroundColor: Colors.black,
          circleBackgroundColor: Colors.black,
          circleBorderColor: textcolor,
          circleSize: 4.0,
          circleBorderThickness: 2.0,
          currentPos: (item) => item.currentValuePos,
          onTextValue: (item) => '€${item.value.toString()}',
          marginBottom: 6.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          radius: 6.0,
          textStyle: const TextStyle(
            color: Colors.white,
            letterSpacing: 0.2,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];
  }
}
