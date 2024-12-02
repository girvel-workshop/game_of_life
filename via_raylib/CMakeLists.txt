cmake_minimum_required(VERSION 3.15)
project(game_of_life C)

find_package(raylib 3.0 REQUIRED)

set(CMAKE_C_STANDARD 11)

add_executable(game_of_life main.c)

target_link_libraries(game_of_life raylib)
