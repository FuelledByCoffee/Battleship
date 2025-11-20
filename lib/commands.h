/*

*/
#pragma once
#include <string_view>

void colorOn(int id);
void colorOff(int id);
void vertPrint(int startY, int X, std::string input);
char wrongInput();
int  intInput(std::string_view prompt, std::string_view failPrompt);
