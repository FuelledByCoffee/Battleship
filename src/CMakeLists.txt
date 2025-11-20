add_executable(battleship main.cpp)
target_link_libraries(battleship PRIVATE battle::ship)
