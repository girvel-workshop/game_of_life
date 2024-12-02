#include "raylib.h"
#include <stdlib.h>

int main(void)
{
    InitWindow(800, 450, "Game of Life");

    while (!WindowShouldClose())
    {
        BeginDrawing();
        
        for (size_t x = 0; x < GetRenderWidth(); x++) {
            for (size_t y = 0; y < GetRenderWidth(); y++) {
                DrawPixel(x, y, rand() < 0.5 * RAND_MAX ? BLACK : WHITE);
            }
        }

        EndDrawing();
    }

    CloseWindow();

    return 0;
}
