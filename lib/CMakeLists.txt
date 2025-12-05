set(CURSES_NEED_NCURSES TRUE)
set(CURSES_NEED_WIDE TRUE)
find_package(Curses REQUIRED)
find_library(MENU_LIBRARY menu)

add_library(battleship.game)
add_library(battle::ship ALIAS battleship.game)

file(GLOB sources *.cpp)
target_sources(battleship.game PRIVATE ${sources})

target_include_directories(
  battleship.game
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE ${CURSES_INCLUDE_DIRS}
)
target_compile_options(battleship.game PRIVATE ${CURSES_FLAGS})
target_link_libraries(
  battleship.game
  PRIVATE ${CURSES_LIBRARIES} ${MENU_LIBRARY}
)
