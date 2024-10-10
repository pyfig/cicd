#include <getopt.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void print_file(char* name);
void settings(FILE* f, char* flags);

char flags[8];
int flagIndex = 0;

int main(int argc, char** argv) {
  int rez = 0;
  static struct option long_options[] = {{"number-nonblank", 0, NULL, 'b'},
                                         {"number", 0, NULL, 'n'},
                                         {"squeeze-blank", 0, NULL, 's'},
                                         {NULL, 0, NULL, 0}};

  while ((rez = getopt_long(argc, argv, "eEvbnstT", long_options, NULL)) !=
         -1) {
    flags[flagIndex] = rez;
    flagIndex++;
  }

  for (int i = optind; i < argc; i++) {
    print_file(argv[i]);
  }

  return 0;
}

void print_file(char* name) {
  FILE* f;
  f = fopen(name, "rt");
  if (f != NULL) {
    settings(f, flags);
  } else {
    printf("ERROR!\n");
  }
}

void settings(FILE* f, char* flags) {
  int c = fgetc(f);
  char prev = '\n';
  while (strchr(flags, 's') != NULL && prev == '\n' && c == '\n') {
    prev = c;
    c = fgetc(f);
    continue;
  }

  // if (strchr(flags, 's') != NULL) fputc(prev, stdout);

  int count = 1;
  int count_n = 0;
  int flag_cont = 0;
  while (c != EOF) {
    if (strchr(flags, 's') != NULL) {
      if (c == '\n') {
        count_n++;
      }
      if (count_n == 3) {
        count_n = 0;
        flag_cont = 1;
      }
      if (c != '\n') {
        count_n = 0;
      }
    }

    if (c != '\n') flag_cont = 0;
    if (strchr(flags, 'E') != NULL) {
      if (c == '\n') {
        fputc('$', stdout);
      }
    }
    if (strchr(flags, 'e') != NULL) {
      if (c == '\n') {
        fputc('$', stdout);
      }
      if (strchr(flags, 'v') != NULL && c >= 0 && c <= 31 && c != '\n' &&
          c != '\t') {
        printf("^");
        c = c + 64;
      }
    }

    if (strchr(flags, 'T') != NULL) {
      if (c == '\t') {
        fputc('^', stdout);
        c = '\t' + 64;
      }
    }
    if (strchr(flags, 't') != NULL) {
      if (c == '\t') {
        fputc('^', stdout);
        c = '\t' + 64;
      }
      if (strchr(flags, 'v') != NULL && c >= 0 && c <= 31 && c != '\n' &&
          c != '\t') {
        printf("^");
        c = c + 64;
      }
    }

    if (strchr(flags, 'n') != NULL) {
      if (prev == '\n') {
        printf("%6d\t", count);
        count++;
      }
    }

    if (strchr(flags, 'b') != NULL) {
      if (prev == '\n' && c != '\n') {
        printf("%6d\t", count);
        count++;
      }
    }
    if (strchr(flags, 'v') != NULL && c >= 0 && c <= 31 && c != '\n' &&
        c != '\t') {
      printf("^");
      c = c + 64;
    }
    if (flag_cont == 0) {
      fputc(c, stdout);
    }
    prev = c;
    c = fgetc(f);
  }
}
