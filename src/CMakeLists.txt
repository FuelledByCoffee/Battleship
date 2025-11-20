add_executable(battleship main.cpp)
target_link_libraries(battleship PRIVATE battle::ship)
set_target_properties(
    battleship
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)
