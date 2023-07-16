# Serial Print

## Setup
#### Required Hardware
* [USB to serial cable](https://www.amazon.com/Sabrent-Converter-Prolific-Chipset-CB-DB9P/dp/B00IDSM6BW)

### Computer setup (windows)
First, obtain a copy of `serialprint_install.EXE`, and run it as administrator. When you run it, it will
extract files. It will then prompt you to install programs. Pressing `return` will proceed with the
installation of the current program. Follow the printed directions for program-specific info. Next, it will
open another `cmd` window. This one will install Serial Print itself. Most likely, it will show some sort
of error related to Git. If not, let it continue automatically, and reboot when it is done. If so, close it.
Afterwards, run `serialprint_install.EXE` again, but close the `cmd` window trying to install programs. It
should continue with the installation automatically. **An internet connection is required.**

### A-Scan setup
Press the settings button, and then press the 6th button on the bottom for `More Settings...`. Here, you
will need to set `Printer` to `None`, unless you have a printer set up. Data won't be sent over serial if
the print fails. Next, set `Serial Link` to `Text with Data`. This is so that measurements can be sent
to have the waveform generated. Finally, set `Serial Baud` to `115200 8-N-1`. Press the 6th button on the
bottom again for `Done`.

## Usage
### Computer
```
ruby lib/serialprint.rb <port> [os] [disable measurements]
```

* `port`: Serial port. Set to `auto` to auto-detect on windows.
* `os`: Operating system being used. Leave blank or set to `-` on linux, and set to `windows` on windows.
* `disable measurements`: Toggle to read measurements or not. Set to `nomeasure` to disable measurements.

Windows default: `ruby lib/serialprint.rb auto windows`

When running, and a print is received, it will open in the browser, and prompt you to print it. Choose
print to PDF to save as a PDF.

### A-Scan
When a patient is recalled, press the print button. The data will appear on the computer.
