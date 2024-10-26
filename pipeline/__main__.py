"""
This file is used to run the pipeline as a module.

Example:
    $ python -m pipeline
"""

import sys
from . import command, data

def main() -> int:
    """
    Main function to run the pipeline.

    Returns:
        int: The exit code of the pipeline.
    """

    # Ensure gmailctl is installed
    if command.ensure_gmailctl_is_installed():
        print("gmailctl is not installed. Please install it before running this command.")
        return 1
    
    # Prepare the data files
    data.prepare_data_files()

    # Execute the init command
    command.execute_gmailctl_init()

    # Execute the apply command and return the exit code
    command.execute_gmailctl_apply('rules.jsonnet')
    return 0

# Run the main function
if __name__ == "__main__":
    sys.exit(main())