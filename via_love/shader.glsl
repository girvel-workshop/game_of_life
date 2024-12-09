vec2 right = vec2(1 / love_ScreenSize.x, 0.);
vec2 down = vec2(0., 1 / love_ScreenSize.y);

// TODO try 2 CELL states with different colours
vec4 CELL = vec4(1.);
vec4 NO_CELL = vec4(0., 0., 0., 1.);

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    // TODO %
    // TODO does neighbours_n being float affect performance?
    float neighbours_n = 
        Texel(tex, mod(texture_coords + right, 1.)).x +
        Texel(tex, mod(texture_coords - right, 1.)).x +
        Texel(tex, mod(texture_coords + down, 1.)).x +
        Texel(tex, mod(texture_coords - down, 1.)).x +
        Texel(tex, mod(texture_coords + right + down, 1.)).x +
        Texel(tex, mod(texture_coords - right + down, 1.)).x +
        Texel(tex, mod(texture_coords + right - down, 1.)).x +
        Texel(tex, mod(texture_coords - right - down, 1.)).x;

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
