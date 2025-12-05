#pragma once
#include <array>

class Board {
public:
	Board();
	void displayUserBoard() const;
	void displayOpponentBoard() const;

	bool hitOnBoard(int x, int y);
	bool missOnBoard(int x, int y);
	void attackBoard(int row, int col);

	void setShips(int size);
	bool checkWin();

private:
	bool inBoard(int i, int j, char direction, char size);

	std::array<std::array<char, 10>, 10> board;
	std::array<std::array<char, 10>, 10> boardCopy;
};
