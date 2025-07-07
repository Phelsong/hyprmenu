from pathlib import Path
from testing import assert_true
from os import getenv


def cache_quick_menu():
    home = Path.home()
    script_dir = home.joinpath(".config/hypr/hyprmenu/quickmenu")
    quick_menu = home.joinpath(".config/hypr/hyprmenu/quickmenu.txt")
    bak = home.joinpath(".config/hypr/hyprmenu/quickmenu.txt.bak")

    try:
        assert_true(home.exists())
        data = quick_menu.read_text().splitlines()
        with open(bak, "w") as bak_buff:
            for line in data:
                bak_buff.write(line)
                bak_buff.write("\n")
    except:
        print("Error: Quick menu file not found")
        return

    try:
        with open(quick_menu, "w") as new:
            for line in data:
                new.write(line)
                new.write("\n")
            for file in script_dir.listdir():
                if file.__str__() not in data:
                    new.write(file.__str__())
                    new.write("\n")

    except:
        print("Error writing to quick menu file")
        return


def main():
    cache_quick_menu()
