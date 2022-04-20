#include <SDL2/SDL.h>
#include <stdlib.h>

SDL_Window *window;
SDL_Renderer *renderer;

typedef struct {
  float r, g, b;
} pixel;

pixel **pixels;
int w, h;

int running;

void sdl_init(int width, int height) {
  w = width;
  h = height;
  running = 1;

  SDL_Init(SDL_INIT_VIDEO);
  window =
      SDL_CreateWindow("Raytracer", SDL_WINDOWPOS_CENTERED,
                       SDL_WINDOWPOS_CENTERED, width, height, SDL_WINDOW_SHOWN);
  renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

  pixels = (pixel **)malloc(sizeof(pixel *) * width);
  for (int i = 0; i < width; i++) {
    pixels[i] = (pixel *)malloc(sizeof(pixel) * height);
  }

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x][y].r = 0.0f;
      pixels[x][y].g = 0.0f;
      pixels[x][y].b = 0.0f;
    }
  }
}

void sdl_draw_pixel(int x, int y, float r, float g, float b) {
  pixels[x][y].r = r;
  pixels[x][y].g = g;
  pixels[x][y].b = b;
}

void sdl_render() {
  SDL_SetRenderDrawColor(renderer, 0.0, 0.0, 0.0, 1.0);
  SDL_RenderClear(renderer);

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < w; y++) {
      SDL_SetRenderDrawColor(renderer, (unsigned)(255 * pixels[x][y].r),
                             (unsigned)(255 * pixels[x][y].g),
                             (unsigned)(255 * pixels[x][y].b), 255);
      SDL_RenderDrawPoint(renderer, x, y);
    }
  }

  SDL_RenderPresent(renderer);

  SDL_Event e;
  while (SDL_PollEvent(&e)) {
    if (e.type == SDL_QUIT || (e.type == SDL_KEYDOWN &&
                               e.key.keysym.scancode == SDL_SCANCODE_ESCAPE)) {
      running = 0;
    }
  }
}

void sdl_quit() {
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit();
}

int sdl_is_running() { return running; }