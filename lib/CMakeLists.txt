set(CURSES_NEED_NCURSES TRUE)
set(CURSES_NEED_WIDE TRUE)
find_package(Curses REQUIRED)
find_library(MENU_LIBRARY menu)

add_library(battleship_game)
add_library(battle::ship ALIAS battleship_game)

file(GLOB sources *.cpp)
target_sources(battleship_game PRIVATE ${sources})

target_include_directories(
  battleship_game
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE ${CURSES_INCLUDE_DIRS}
)
target_compile_options(battleship_game PRIVATE ${CURSES_FLAGS})
target_link_libraries(
  battleship_game
  PRIVATE ${CURSES_LIBRARIES} ${MENU_LIBRARY}
)

enable_sanitizers(battleship_game)
