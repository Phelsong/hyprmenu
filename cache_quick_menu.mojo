from asyncio import run
from pathlib import Path
from os import getenv


def cache_quick_menu():
    HOME = getenv("HOME")
    script_dir = Path(f"{HOME}/.config/hypr/hyprmenu/quick_menu")
    quick_menu = Path(f"{HOME}/.config/hypr/hyprmenu/quick_menu.txt")
    with open(quick_menu, "r") as existing:
        data = existing.readlines()
    with open(quick_menu, "w") as new:
        for line in data:
            new.write(line)
        for file in script_dir.iterdir():
            if file not in data:
                new.write(f"{file.name}\n")


if __name__ == "__main__":
    run(cache_quick_menu())
