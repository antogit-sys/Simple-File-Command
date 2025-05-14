#include <stdio.h>
#include <magic.h>
#include <string.h>
#include "../include/sfile.h"

/* Function that calculates the maximum filename length */
size_t get_max_filename_length(int argc, char **argv) {
    size_t max_filename_length = 0;
    
    for(int i = 1; i < argc; ++i){
        size_t filename_length = strlen(argv[i]);
        
        /* If a longer filename is found, update the value */
        if(filename_length > max_filename_length)
            max_filename_length = filename_length;
    }
    
    return max_filename_length;
}

/* Function that gets the file type using libmagic */
const char* get_file_type(const char* filename, magic_t mc){
    const char *file_type = magic_file(mc, filename);
    
    /* Handle the case where there is an error analyzing the file */
    if(file_type == NULL){
        fprintf(stderr, "Error analyzing the file: %s\n", magic_error(mc));
        file_type = "Unknown";  // If there's an error, return "Unknown"
    }

    return file_type;
}

