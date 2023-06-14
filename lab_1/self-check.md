# Bash self-check questions:

1. From which directory will `cd ..` not move to the parent directory?

from the root directory (/), because the root directory is the top-level directory, and it doesn't have a parent.

2. Are the paths `~/lab_1` and `~/lab_2` relative or
    absolute?

The paths ~/lab_1 and ~/lab_2 are absolute because they start from the home directory (~), which is a fixed location.

3. What are the two ways in which we could inspect the contents of the `/` directory
    from your own home directory.

Either ls / or cd /; ls.

4. What is the difference in behaviour of `ls`
    when run with the `-1` (digit) and `-l` (letter) options? How does
    `ls -1` differ from `ls` without options?

ls -1 displays one file per line while ls -l displays a long format listing with extra file details. ls -1 and ls without options have the same behavior if the output is to the terminal, but if the output is being piped or redirected, ls doesn't use the one-line format.

5. If you want to hide the group names in the long listing format,
    which extra options would you need to set when searching within the home
    directory?

To hide group names in the long listing format, use the ls -lo option.

6. Try accessing the documentation for the command `man` all the ways
    you can think of. Was there a difference in the output depending on
    how we asked to view the documentation? Could you access the
    documentation for the `ls` command all three ways?

You can view the man documentation with man man, man --help, and info man. These all show the documentation, but in different formats. You can view the ls documentation with man ls, ls --help, and info ls.

7. Complete the table.

    | **Command** | **Description of function** |
    | :---------- | :-------------------------- |
    | `mv`        | Move or rename files or directories.
    | `cp`        | Copy files or directories.
    | `rm`        | Remove files or directories.
    | `mkdir`     | Create new directories.
    | `cat`       | Concatenate and display file contents.
    | `less`      | View file contents with backward navigation.
    | `wc`        | Count lines, words, and bytes in files.
    | `head`      | Display the beginning of a file.
    | `tail`      | Display the end of a file.
    | `echo`      | Print arguments to the standard output.
    | `cut`       | Remove sections from lines of files.
    | `sort`      | Sort lines in text files.
    | `uniq`      | Report or omit repeated lines.
    | `wget`      | Network downloader.
    | `gunzip`    | Compress or expand files.

8. What is “stdin” an abbreviation of?

standard input

9. Why does `echo ~` output `/home/user` when you execute it? What
    would it output if a user with a different home directory executed
    it? What happens when you execute `echo ~/*`?

echo ~ outputs the path to the current user's home directory. If a user with a different home directory executes it, the path to that user's home directory will be output. echo ~/* will output the paths to all the files and directories in the current user's home directory.

10. What does the `'^>'` mean in the grep command where
    some file is being searched?

regular expression that matches lines that start with >.

11. Before you executed the `chmod` command on the db.sh file,
    what were the permissions? What did these permissions allow you to
    do as a user, as members of your user group, as another user not in
    your user group?

Before executing the chmod command on db.sh, the permissions would be the default permissions set by the umask command, which typically allow the user to read, write, and execute the file, while group members and other users can read and execute it.

12. What did the 4 digit do to the permissions of db.sh with the
    command `chmod 774 db.sh`?

The chmod 774 db.sh command sets the permissions of db.sh to read, write, and execute for the user (7), and read and execute for the group members (7) and other users (4).

13. Can you leave comments above the shebang line; `#!`?

No, you cannot leave comments above the shebang line; #!. The shebang must be the first line in the script for it to be recognized.
