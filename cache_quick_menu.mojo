from pathlib import Path
from os import getenv

# !! NOT PORTED YET

def cache_quick_menu():
    HOME = getenv("HOME")
    script_dir = Path(String("{}/.config/hypr/hyprmenu/quickmenu").format(HOME))
    quick_menu = Path(String("{}/.config/hypr/hyprmenu/quickmenu.txt").format(HOME))
    with open(quick_menu, "r") as existing:
        data = existing.read()
    with open(quick_menu, "w") as new:
        for line in data:
            new.write(line)
        for file in script_dir.listdir():
            if file not in data:
                new.write(f"{file.name}\n")


def main():
   cache_quick_menu() 
