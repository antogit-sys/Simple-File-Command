#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <magic.h>
#include "../include/sfile.h"


void print_banner(const char*);

int main(int argc, char** argv)  
{
    magic_t magic_cookie;  // Variable to store the magic cookie
    uint16_t num_space;    // Number of spaces for output alignment
    size_t error_count = 0; // Count the number of errors (files not found)

    /* Check if arguments were passed to the program */
    if(argc < 2){
        print_banner(argv[0]);
        exit(EXIT_FAILURE);
    }
    
    // - Initialize the magic structure (magic_cookie)
    magic_cookie = magic_open(MAGIC_NONE);
    CHECK_MAGIC_ERROR(magic_cookie);

    // - Load the magic database
    LOAD_MAGIC_DB(magic_cookie);

    // - Get the maximum filename length for output alignment
    num_space = get_max_filename_length(argc, argv);
    
    for(int i = 1; i < argc; ++i){
        // - Check if the file does not exist
        if(NOT_FOUND(argv[i])){

            PRINT_ERROR_MSG_FILE_NOT_FOUND(argv[i], num_space);
            ++error_count;  // Increment the error count
            
            continue;  // Move to the next file
        }
        
        // Print the file type if the file exists
        PRINT_FILE_INFO(argv[i], num_space, magic_cookie);
    }

    /* If there were any errors, print a summary */
    if(error_count > 0){
        putchar('\n');
        fprintf(stderr, "Summary %zu file(s) could not be opened.\n", error_count);
    }
    // - Free the memory used by libmagic
    magic_close(magic_cookie);

    return EXIT_SUCCESS;
}

void print_banner(const char* program_name){
    puts("         _____ __   ");
    puts("   _____/ __(_) /__ ");
    puts("  / ___/ /_/ / / _ \\");
    puts(" (__  ) __/ / /  __/");
    puts("/____/_/ /_/_/\\___/     By Ucc3tto!");
    puts("                    ");
    puts("version 1.0");
    puts("======================================");
    puts("Determine type of FILEs using libmagic\n");
    printf("\tUsage:\n\t\t%s <file_name>\n", program_name);
    printf("\tExample:\n\t\t%s data.txt\n",program_name);
    printf("\tManual:\n\t\tman %s\n",program_name);
    puts("======================================");

}

