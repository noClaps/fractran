#include "./nc.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

void c_exit(int64_t code) { exit(code); }

nc_str *c_read(nc_str *path) {
  FILE *file = fopen(path->data, "rb");
  if (file == NULL)
    return NULL;

  size_t capacity = 4096;
  size_t length = 0;
  char *text = calloc(4096, sizeof(char));
  if (text == NULL) {
    fclose(file);
    return NULL;
  }

  for (;;) {
    if (capacity - length < 2) {
      size_t new_capacity = capacity * 2;
      if (new_capacity <= capacity) {
        free(text);
        fclose(file);
        return NULL;
      }

      char *grown = realloc(text, new_capacity * sizeof(char));
      if (grown == NULL) {
        free(text);
        fclose(file);
        return NULL;
      }
      text = grown;
      capacity = new_capacity;
    }

    size_t n = fread(text + length, sizeof(char), capacity - length - 1, file);
    length += n;

    if (ferror(file)) {
      free(text);
      fclose(file);
      return NULL;
    }
    if (feof(file))
      break;
  }

  text[length] = '\0';
  fclose(file);

  return nc_str_from_cstr(text);
}

int64_t c_ilog2(int64_t n) { return (int64_t)log2(n); }
