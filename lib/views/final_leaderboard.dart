import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalLeaderboard extends StatelessWidget {
  final scoreboard;
  final String winner;
  FinalLeaderboard(this.scoreboard, this.winner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.purple.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header Title
                  Text(
                    'Leaderboard',
                    style: GoogleFonts.pressStart2p(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Bobbers',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$winner has won the game!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Leaderboard List
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        // Create a sorted copy of userData (each Map should contain keys like 'name' and 'score')
                        final List<Map> sortedUserData = List.from(scoreboard);
                        sortedUserData.sort((a, b) {
                          int scoreA =
                              int.tryParse(a['score']?.toString() ?? '0') ?? 0;
                          int scoreB =
                              int.tryParse(b['score']?.toString() ?? '0') ?? 0;
                          return scoreB.compareTo(scoreA);
                        });

                        return ListView.builder(
                          itemCount: sortedUserData.length,
                          itemBuilder: (context, index) {
                            // Convert map values to a list for easier access.
                            var data = sortedUserData[index].values.toList();

                            // Determine card background color based on rank.
                            Color cardColor;
                            if (index == 0) {
                              cardColor = const Color(0xFFFFD700); // Gold
                            } else if (index == 1) {
                              cardColor = const Color(0xFFC0C0C0); // Silver
                            } else if (index == 2) {
                              cardColor = const Color(0xFFCD7F32); // Bronze
                            } else {
                              cardColor = Colors.white;
                            }

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: cardColor,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.deepPurple.shade200,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  data.elementAt(0),
                                  style: const TextStyle(
                                    fontSize: 23,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Text(
                                  data.elementAt(1),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}