#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <magic.h>

#ifndef _SFILE_H_
#define _SFILE_H_

/* MACRO UTILITY */
/* Macro to check for errors in libmagic */
#define CHECK_MAGIC_ERROR(mc) \
    do{ \
        if ((mc) == NULL) { \
            fprintf(stderr, "Error opening libmagic\n"); \
            exit(EXIT_FAILURE); \
        } \
    }while(0)

/* Macro to load the magic database and check for errors */
#define LOAD_MAGIC_DB(mc) \
    do{ \
        if(magic_load(mc, NULL) != 0){ \
            fprintf(stderr,"Error loading magic database: %s\n", magic_error(mc)); \
            magic_close(mc); \
            exit(EXIT_FAILURE); \
        } \
    }while(0)

/* Macro to check if a file exists */
#define NOT_FOUND(file) \
    (access((file), F_OK) == -1)

/* Formatting the output to display file info */
#define PRINT_FILE_INFO(filename, num_space, mc) \
    (printf("%s:%-*s %s\n", filename, (num_space - (int)strlen(filename)), "", get_file_type(filename, mc)))    

#define PRINT_ERROR_MSG_FILE_NOT_FOUND(file, num_space) \
    fprintf(stderr, "%s:%-*s cannot open `%s` (No such file or directory)\n", \
            (file), (num_space) - (int)strlen(file), "", (file));

/* Function to get the maximum length of a filename */
size_t get_max_filename_length(int, char**); // arguments: argc, **argv

/* Function to get the file type using libmagic */
const char* get_file_type(const char*, magic_t);

#endif

