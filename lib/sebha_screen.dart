import 'dart:math' as math;

import 'package:flutter/material.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  List<String> zekrList = ['سبحان الله', 'الحمد لله', 'الله أكبر'];
  int zekrIndex = 0;
  int count = 0;
  static const beadsPerZekr = 33;

  void countTap() {
    setState(() {
      if (zekrIndex == zekrList.length - 1) {
        zekrIndex = 0;
        count = 1;
      } else if (count == beadsPerZekr) {
        zekrIndex++;
        count = 1;
      } else {
        count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var ringSize = math.min(size.width * 0.68, size.height * 0.49);
    var beadSize = ringSize * 0.105;
    var radius = (ringSize - beadSize) / 2;
    var visibleBeads = zekrIndex == zekrList.length - 1 ? beadsPerZekr : count;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff202020),
          image: DecorationImage(
            image: AssetImage('assets/images/sebha_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: countTap,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/sebha_head.png',
                      height: ringSize * 0.19,
                    ),
                    SizedBox(
                      height: ringSize,
                      width: ringSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: radius * 2,
                            width: radius * 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xffe2be7f),
                              ),
                            ),
                          ),
                          for (int i = 0; i < visibleBeads; i++)
                            buildBead(i, radius, beadSize),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: Text(
                              zekrList[zekrIndex],
                              key: ValueKey(zekrIndex),
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBead(int index, double radius, double beadSize) {
    var angle = index * 2 * math.pi / beadsPerZekr - math.pi / 2;
    return Positioned(
      left: radius + radius * math.cos(angle),
      top: radius + radius * math.sin(angle),
      child: Transform.rotate(
        angle: angle + math.pi / 2,
        child: Image.asset(
          'assets/images/sebha_bead.png',
          width: beadSize,
          height: beadSize,
        ),
      ),
    );
  }
}
