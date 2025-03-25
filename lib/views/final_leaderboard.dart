import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/widgets/custom_button.dart';
import 'package:scriclone/views/home_screen.dart';
import 'dart:async';

class FinalLeaderboard extends StatelessWidget {
  final List<Map<String, dynamic>> scoreboard;

  const FinalLeaderboard(this.scoreboard, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedPlayers = List.from(scoreboard);
    sortedPlayers.sort((a, b) {
      int scoreA = int.tryParse(a['score']?.toString() ?? '0') ?? 0;
      int scoreB = int.tryParse(b['score']?.toString() ?? '0') ?? 0;
      return scoreB.compareTo(scoreA);
    });

    sortedPlayers.asMap().forEach((index, player) {
      player['rank'] = index + 1;
    });

    List<Map<String, dynamic>> topThree = [];
    if (sortedPlayers.length >= 3) {
      topThree = [
        sortedPlayers[0],
        sortedPlayers[1],
        sortedPlayers[2]
      ];
    } else if (sortedPlayers.length == 2) {
      topThree = [
        sortedPlayers[0],
        sortedPlayers[1],
        {}
      ];
    } else if (sortedPlayers.length == 1) {
      topThree = [sortedPlayers[0], {}, {}];
    }

    Timer(Duration(seconds: 30), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Leaderboard",
          style: GoogleFonts.bungee(
            textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[Color(0xFFFFD700), Color(0xFFFFA500)],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTopPlayerCard(
                        topThree.length > 1 ? topThree[1] : {}, 2),
                    _buildTopPlayerCard(
                        topThree.isNotEmpty ? topThree[0] : {}, 1),
                    _buildTopPlayerCard(
                        topThree.length > 2 ? topThree[2] : {}, 3),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Center(
                          child: Text('Rank',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text('Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Center(
                          child: Text('Points',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: sortedPlayers.length,
                  itemBuilder: (context, index) {
                    return _buildPlayerRankItem(sortedPlayers[index], index);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: 'Play Again',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPlayerCard(Map<String, dynamic> player, int position) {
    if (player.isEmpty) {
      return SizedBox(width: 100);
    }

    double cardWidth = position == 1 ? 120.0 : 100.0;
    double avatarSize = position == 1 ? 70.0 : 60.0;
    double cardHeight = position == 1 ? 160.0 : 130.0;
    Color cardColor = position == 1
        ? Colors.blue
        : position == 2
            ? Colors.amber
            : Colors.brown;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                player['name'][0].toUpperCase(),
                style: TextStyle(
                  fontSize: position == 1 ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Player Name
          Text(
            player['name'],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: position == 1 ? 14 : 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            player['score'].toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: position == 1 ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRankItem(Map<String, dynamic> player, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
            0.85),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  '#${index + 1}',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        player['name'][0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      player['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  player['score'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
