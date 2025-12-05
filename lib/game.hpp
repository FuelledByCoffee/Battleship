#pragma once

#include "player.hpp"
#include <vector>

class Game {
public:
	Game() = default;

	void        playGame(); // starts gameloop : called externally
	const char *getName(unsigned playerNumber);
	void        setBoards();
	bool        playAgain(); // returns false currently

private:
	void initPlayers(); // adds a player to the game

	std::vector<Player> players;
	bool gameState = true; // for the gameloop while loop (maybe offer the
	                       // chance to change mind.)
	int  winner;
};
