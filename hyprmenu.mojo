from subprocess import run
from os import getenv
from testing import assert_true
from pathlib import Path
from sys import argv
from emberjson import *


fn get_active_window() -> String:
    # would like this to be a dict when they support String indexs
    APP_TABLE: List[String] = [
        "dev.warp.Warp",
        "steam",
        "tidal-hifi",
        "dev.zed.Zed",
        "dev.zed.Zed-Preview",
        "com.mitchellh.ghostty",
        # "kitty"
    ]
    try:
        hyprctl = run("hyprctl activewindow -j")
        active = parse(hyprctl).object()
        if (
            not active["initialClass"].string()
            and not active["initialTitle"].string()
        ):
            print("No active window found")
            return String("quickmenu")
        elif active["initialClass"].string() in APP_TABLE:
            return APP_TABLE[APP_TABLE.index(active["initialClass"].string())]
        elif active["initialTitle"].string() in APP_TABLE:
            return APP_TABLE[APP_TABLE.index(active["initialTitle"].string())]
        else:
            return String("quickmenu")
    except:
        return String("quickmenu")


fn select_cmd(menu_path: Path, script_path: Path) -> String:
    STDIO_RUNNER: String = (
        "| anyrun --plugins libstdin.so --show-results-immediately true"
        " --max-entries 5 "
    )
    try:
        print(menu_path)
        with open(menu_path, "r") as buff:
            param = run("echo " + "'" + buff.read() + "'" + STDIO_RUNNER)
            print(param)
            return String(
                script_path.joinpath(param)
            )
    except:
        return String("error")
    return String("error")


fn hyprmenu(get_window: Bool = False, menu: String="quick") -> None:
    HOME: Path = getenv("HOME")
    SCRIPT_PATH: Path = HOME.joinpath(".config/hypr/hyprmenu/quickmenu")
    try:
        if get_window:
            _menu = get_active_window()
            _menu_path: Path = HOME.joinpath(
                String(".config/hypr/hyprmenu/{}.txt").format(_menu)
            )
        elif menu != "quick":
            print(menu)
            _menu_path: Path = HOME.joinpath(
                String(".config/hypr/hyprmenu/{}.txt").format(menu)
            )
        else:
            _menu_path: Path = HOME.joinpath(
                ".config/hypr/hyprmenu/quickmenu.txt"
            )
        

        cmd: String = select_cmd(_menu_path, SCRIPT_PATH)
        # add some validation here
        print(cmd)
        assert_true(cmd) 
        run(cmd)
    except:
        print("No menu found for this window")


fn main() -> None:
    if len(argv()) <= 1:
        hyprmenu(True)
    else:
        if argv()[1] == "quick":
            hyprmenu()
        else:
            hyprmenu(menu=argv()[1])
