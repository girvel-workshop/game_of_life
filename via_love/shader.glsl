vec2 right = vec2(1 / love_ScreenSize.x, 0.);
vec2 down = vec2(0., 1 / love_ScreenSize.y);

vec4 CELL = vec4(1.);
vec4 NO_CELL = vec4(0., 0., 0., 1.);

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    // TODO %
    // TODO does neighbours_n being float affect performance?
    float neighbours_n = 
        Texel(tex, texture_coords + right).x +
        Texel(tex, texture_coords - right).x +
        Texel(tex, texture_coords + down).x +
        Texel(tex, texture_coords - down).x +
        Texel(tex, texture_coords + right + down).x +
        Texel(tex, texture_coords - right + down).x +
        Texel(tex, texture_coords + right - down).x +
        Texel(tex, texture_coords - right - down).x;

    vec4 it = Texel(tex, texture_coords);

    // TODO does if cause performance hit?
    if (it.x == 1.) {
        if (neighbours_n < 2.) return NO_CELL;
        if (neighbours_n < 4.) return CELL;
        return NO_CELL;
    }

    if (neighbours_n == 3.) return CELL;
    return NO_CELL;
}
