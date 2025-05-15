#!/usr/bin/env python3
# Import necessary modules
from sys import argv, stderr, exit  # argv: list of command-line arguments, stderr: error stream, exit: to exit the program
from os import path  # path: for working with file paths
from magic import Magic  # Magic: for determining file types using the libmagic library


# Main function that coordinates the execution of the program
def main(argc, argv):
    done = 0  # Variable to mark if the execution was completed successfully (0: success, 1: error)

    # If no files are passed as arguments, display the banner and exit
    if argc < 2:
        print_banner(argv[0])  # Display the banner with program information
        done = 1  # Set done to 1 to indicate the program exited due to missing arguments
    else:
        analyze_files(argv[1:])  # If files are provided, start analyzing the files

    return done  # Return the result: 0 (success) or 1 (error)


# Function to print an error message to stderr
def print_stderr(message):
    """
    Prints an error message to the stderr stream.
    stderr is used to send error messages, keeping them separate from the main output.
    """
    print(message, file=stderr)  # Use stderr to send the error message


# Function that shows an informational banner at the start of the program
def print_banner(program_name):
    """
    Prints an informational banner at the start of the program, showing name, version,
    usage example, and manual.
    """
    print("         _____ __   ")
    print("   _____/ __(_) /__ ")
    print("  / ___/ /_/ / / _ \\")
    print(" (__  ) __/ / /  __/")
    print("/____/_/ /_/_/\\___/     By Ucc3tto!")
    print()
    print("version 1.0 (py)")
    print("======================================")
    print("Determine type of FILEs using libmagic\n")
    print(f"\tUsage:\n\t\t{program_name} <file_name>")
    print(f"\tExample:\n\t\t{program_name} data.txt")
    print(f"\tManual:\n\t\tman {program_name}")
    print("======================================")


# Function that analyzes the files passed as arguments
def analyze_files(files):
    """
    Analyzes the files passed as arguments, determines the type of each file,
    and prints the results.
    """
    # Find the maximum filename length, useful for formatting the output
    max_len = get_max_filename_length(files)
    
    # Create a Magic object to determine the type of each file
    magic_obj = Magic()  
    
    error_count = 0  # Counter for files that could not be opened

    # Analyze each file
    for f in files:
        # Calculate padding to align file names properly
        padding = ' ' * (max_len - len(f))

        # Check if the file exists, if not, print an error message
        if not path.exists(f):
            print_stderr(f"{f}:{padding} cannot open '{f}' (No such file or directory)")  # Error message
            error_count += 1  # Increment the error count
            continue  # Skip to the next file without attempting to determine its type

        # If the file exists, determine its type and print it
        file_type = get_file_type(f, magic_obj)
        print(f"{f}:{padding} {file_type}")  # Print the file type

    # If there were any errors, print a summary with the number of files that couldn't be opened
    if error_count:
        print_stderr(f"\nSummary: {error_count} file(s) could not be opened.")


# Function that returns the maximum filename length for formatting the output
def get_max_filename_length(files):
    """
    Calculates the length of the longest file name.
    This is used to format the output and align file names.
    """
    return max(len(f) for f in files) if files else 0  # Return the length of the longest file name


# Function that determines the type of a file
def get_file_type(filename, magic_obj):
    """
    Determines the type of a file using the 'magic' object.
    If the file is a directory, it returns 'directory'.
    Otherwise, it tries to determine the file type with libmagic.
    """
    done = ""  # Variable that will hold the file type
    try:
        # If the file is a directory, return 'directory'
        if path.isdir(filename):
            done = "directory"
        else:
            # Use libmagic to determine the file type
            done = magic_obj.from_file(filename)
    except Exception as e:
        # If there's an error (e.g., the file is unreadable), handle the error
        print_stderr(f"Error analyzing '{filename}': {e}")  # Print the error
        done = "Unknown"  # If the type cannot be determined, return 'Unknown'
    
    return done  # Return the file type (or 'Unknown' in case of error)


# Entry point of the program, executed only if the file is run directly
if __name__ == "__main__":
    exit(main(len(argv), argv))  # Call the main function, passing the number of arguments and the arguments themselves

