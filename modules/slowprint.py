#!/bin/python3
import sys
from time import sleep
import random
import os
import cursor
import argparse
from datetime import datetime



def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-c',
        '--center',
        action='store_true',
        help="center text")
    parser.add_argument('-s', '--sleeptime', type=float, default=.07)
    parser.add_argument('-l', '--loadtime', action='store_true')
    return parser.parse_args()


def loading(sleeptime=.07):
    for i in list("/‒\\|" * random.randint(0, 10)):
        print(i, end='\r', flush=True)
        sleep(sleeptime)
    print(' ', end='\r')


def ellieprint(x, sleeptime=.07, loadtime=True):
    global progress
    if x.endswith('\n'):
        x = x[:-1]
    if not x.isspace() and loadtime:
        loading()
    if args.center:
        x = x.center(os.get_terminal_size()[0])
    for i in x:
        progress += 1
        print(i, end='', flush=True)
        sleep(sleeptime if i != " " else .01)
        progressbar()
    print()

def progressbar():
    global progress
    global counter
    global ratio
    if progress % ratio == 0:
        counter += 1
    print("\0337", end='')  # Save cursor position
    print(f"\033[{lines};0f", end='')  # Move cursor to the bottom margin
    print('—'*counter + "→", end='')  # Write the date
    #print(f"{counter=}, {progress=}, {ratio=}, {progress%ratio=}", end='')
    print("\0338", end='')  # Restore cursor position

def main():
    global ratio
    text = list(sys.stdin.readlines())
    total_width = os.get_terminal_size()[0]
    ratio = len("\n".join(text))//total_width
    for line in text:
        ellieprint(line, sleeptime=args.sleeptime, loadtime=args.loadtime)

if __name__ == '__main__':
    columns, lines = os.get_terminal_size()
    counter = 0
    progress = 0
    print("\n", end='')  # Ensure the last line is available.
    print("\0337", end='')  # Save cursor position
    print(f"\033[0;{lines-1}r", end='')  # Reserve the bottom line
    print("\0338", end='')  # Restore the cursor position
    print("\033[1A", end='')  # Move up one line
    args = parse_args()
    with cursor.HiddenCursor():
        try:
            main()
        except KeyboardInterrupt:
            ellieprint("\n\n\n")
            ellieprint("Goodbye!", sleeptime=.01, loadtime=False)
        finally:
            print(f"\0337\033[0;{lines}r\033[{lines};0f\033[0K\0338")
            exit(130)
        
    print(f"\0337\033[0;{lines}r\033[{lines};0f\033[0K\0338")
    exit(0)
