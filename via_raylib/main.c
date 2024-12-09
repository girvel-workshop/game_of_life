#include "raylib.h"
#include <stdlib.h>

const char *shader_source = "\
    #version 330\n\
    in vec2 fragTexCoord;\n\
    in vec4 fragColor;\n\
    uniform sampler2D texture0;\n\
    out vec4 finalColor;\n\
    void main() {\n\
       vec4 texel = texture(texture0, fragTexCoord) * fragColor;\n\
       if (texel.r > .5) {\n\
          finalColor = vec4(0.5, 0., 0., 1.);\n\
       } else {\n\
          finalColor = vec4(0., 0., 0., 1.);\n\
       }\n\
    }\n\
";

int main(void) {
    const int screen_w = 800;
    const int screen_h = 450;
    InitWindow(screen_w, screen_h, "Game of Life");
    Shader shader = LoadShaderFromMemory(0, shader_source);

    while (!WindowShouldClose()) {
        BeginDrawing();
            BeginShaderMode(shader);
                for (size_t x = 0; x < GetRenderWidth(); x++) {
                    for (size_t y = 0; y < GetRenderWidth(); y++) {
                        DrawPixel(x, y, rand() < 0.5 * RAND_MAX ? BLACK : WHITE);
                    }
                }
            EndShaderMode();
            DrawFPS(700, 15);
        EndDrawing();
    }

    UnloadShader(shader);
    CloseWindow();

    return 0;
}
