add_executable(testbattleship test_driver.cpp)
target_link_libraries(testbattleship PRIVATE battle::ship)
add_test(NAME test_driver COMMAND testbattleship)
