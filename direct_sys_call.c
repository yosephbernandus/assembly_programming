#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  int fd = open("sample.csv", O_RDONLY);
  if (fd == -1) {
    perror("Failed to open file");
    return 1;
  }

  char byte;
  char line[1024] = {0};
  int pos = 0;

  // Read one byte at a time - very inefficient
  while (read(fd, &byte, 1) > 0) {
    if (byte == '\n') {
      // Process the completed line
      line[pos] = '\0';
      printf("CSV Row: %s\n", line);

      // Reset for next line
      pos = 0;
      line[0] = '\0';
    } else {
      // Add byte to current line
      line[pos++] = byte;
    }
  }

  close(fd);
  return 0;
}
