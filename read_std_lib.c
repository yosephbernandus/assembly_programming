#include <stdio.h>
#include <string.h>

int main() {
  FILE *file = fopen("sample.csv", "r");
  if (!file) {
    perror("Failed to open file");
    return 1;
  }

  char line[1024];

  // fgets automatically uses buffered I/O
  while (fgets(line, sizeof(line), file) != NULL) {
    // Remove newline character if present
    size_t len = strlen(line);
    if (len > 0 && line[len - 1] == '\n') {
      line[len - 1] = '\0';
    }

    printf("CSV Row: %s\n", line);
  }

  fclose(file);
  return 0;
}
