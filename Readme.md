# BackMeUp

**Disclaimer: This script most likely is not for you. Use at your own risk. I cannot be held responsible for data loss.**

This script has been written to provide an _easy to use_ backup solution *for friends & family* who forget to backup all the time. **I set it up** on their machines (the semi-complicated part) and all _they_ have to do is double click a file and provide a small summary.

## Installation

```bash
# 1. Enter home directory
$ cd

# 2. Download files
$ git clone https://github.com/beulenyoshi/backmeup.git

# 3. Enter directory and add a 'destinations.txt' file containing backup paths (see sample file)

# 4. Set execution rights
$ chmod 777 # Did I mention you really shouldn't use this script unless you trust me?

# 5. (Optional: Execute git config)

# 6. Enter home directory and rename / hide folder
$ cd
$ mv backmeup .backmeup

# 7. Enter the path you would like to back up from now on
$ cd <path>

# 8. Create hard link to script
$ ln -h ~/.backmeup/BackMeUp.command
```

## Run

Double click the `BackMeUp.command` within the path you would like to backup. Follow the instructions and simply type in a short summary (or the current date) of your changes.

## Update

~The script updates automatically each time you run it.~

I removed this feature because I execute the script for ease of use with a bunch of access rights. If I updated this script automatically, someone could inject malicious code into the user's machine if he gained access to this repository.


## Authors

* **Thomas Johannesmeyer** - [www.geeky.gent](http://geeky.gent)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Support

The framework and code are provided as-is, but if you need help or have suggestions, you can contact me anytime at [opensource@geeky.gent](mailto:opensource@geeky.gent?subject=Tagsnag).


## I'd like to hear from you

If you have got any suggestions, please feel free to share them with me. :)
