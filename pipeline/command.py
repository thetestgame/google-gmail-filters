"""
This module provides functions to execute gmailctl commands.
"""

import os
import sys

def ensure_gmailctl_is_installed() -> bool:
    """
    Verifies the command gmailctl exists in the PATH.
    """

    # Check if we can execute the command
    if not os.system('command -v gmailctl > /dev/null 2>&1'):
        return False

    return True

def execute_gmailctl_command(command: str, args: list = []) -> int:
    """
    Executes a gmailctl command with the given arguments and returns the exit code.

    Args:
        command (str): The command to execute.
        args (list): The arguments to pass to the command.

    Returns:
        int: The exit code of the command.
    """

    # Construct the command
    command = f"gmailctl {command} {' '.join(args)}"

    # Execute the command
    return os.system(command)

def execute_gmailctl_init() -> None:
    """
    Executes the gmailctl init command. This function will throw if gmailctl is not installed
    or the init exit code is non-zero.
    """

    # Ensure gmailctl is installed
    if ensure_gmailctl_is_installed():
        print("gmailctl is not installed. Please install it before running this command.")
        sys.exit(1)

    # Execute the init command
    if execute_gmailctl_command('init'):
        print("An error occurred while initializing gmailctl.")
        sys.exit(1)

def execute_gmailctl_apply(filename: str) -> None:
    """
    Executes the gmailctl apply command. This function will throw if gmailctl is not installed
    or the apply exit code is non-zero.

    Args:
        filename (str): The filename to apply.
    """

    # Ensure gmailctl is installed
    if ensure_gmailctl_is_installed():
        print("gmailctl is not installed. Please install it before running this command.")
        sys.exit(1)

    # Execute the apply command
    if execute_gmailctl_command('apply', [filename]):
        print("An error occurred while applying the configuration.")
        sys.exit(1)