#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define BUFFER_SIZE 64 * 1024 // 64KB buffer, like your Rust code

int main() {
  int fd = open("sample.csv", O_RDONLY);
  if (fd == -1) {
    perror("Failed to open file");
    return 1;
  }

  char buffer[BUFFER_SIZE];
  char line[1024] = {0};
  int line_pos = 0;
  int bytes_read;

  // Read large chunks at a time - more efficient
  while ((bytes_read = read(fd, buffer, BUFFER_SIZE)) > 0) {
    for (int i = 0; i < bytes_read; i++) {
      char byte = buffer[i];

      if (byte == '\n') {
        // Process the completed line
        line[line_pos] = '\0';
        printf("CSV Row: %s\n", line);

        // Reset for next line
        line_pos = 0;
        line[0] = '\0';
      } else {
        // Add byte to current line
        line[line_pos++] = byte;
      }
    }
  }

  close(fd);
  return 0;
}
