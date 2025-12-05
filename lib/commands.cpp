/*
input checkers
*/
#include <algorithm>
#include <cctype>
#include <string_view>
#ifdef __linux__
	#include <cursesw.h>
#endif
#ifdef _WIN32
	#include <ncurses/cursesw.h>
#endif

#include "commands.hpp"
#include <iostream>
#include <limits>
#include <string>

void colorOn(int id) { // basically a simpler way to turn on colours, less
	                   // verbose
	attron(COLOR_PAIR(id));
}

void colorOff(int id) { // same but off
	attroff(COLOR_PAIR(id));
}

void vertPrint(int startY, int X, std::string_view input) {
	for (int i = 0; i < input.size(); i++) {
		mvprintw(i + startY, X, "%c", input.at(i));
	}
}


// Did not get used
char wrongInput() {
	char inp;
	while (true) {
		try {
			std::cin >> inp;

			if (std::cin.fail()) {
				throw std::invalid_argument("Invalid Input");
			}

			// Check for trailing characters after the character
			char remaining;
			std::cin.get(remaining);
			if (remaining != '\n') {
				throw std::invalid_argument("Invalid Input");
			}
			break;

		} catch (const std::invalid_argument &e) {
			// Handle the case where the user enters an invalid character
			std::cout << e.what() << std::endl;
			std::cin.clear(); // Clear the error flag

			// Clear the input buffer
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
	}
	return inp;
}

int intInput(std::string_view prompt, std::string_view failPrompt) {
	std::string input;
	while (true) {
		std::cout << prompt;
		std::getline(std::cin, input);
		if (std::ranges::all_of(input, ::isdigit)) break;
		std::cout << failPrompt << std::endl;
	}
	return std::stoi(input); // removes whitespace and stores input in number
}
