from subprocess import run
from os import getenv
from pathlib import Path
from tempfile import NamedTemporaryFile
from sys import argv
from emberjson import *


fn get_active_window() -> String:
    APP_TABLE: OwnedKwargsDict[String, String] = {
        "dev.warp.Warp": "warp",
        "steam": "steam",
        "tidal-hifi": "tidal",
        "dev.zed.Zed": "zed",
        "dev.zed.Zed-Preview": "zed",
        "com.mitchellh.ghostty": "ghostty"
    }
    try:
        hyprctl = run("hyprctl activewindow -j")
        print(hyprctl)
        active = parse(hyprctl).object()

        if (
            not active["initialClass"].string()
            and not active["initialTitle"].string()
        ):
            print("No active window found")

        menu = ""
        if active["initialClass"].string() in APP_TABLE:
            val = active["initialClass"].string()
            print(val)
            menu = APP_TABLE.get(ascii(val))
        elif active["initialTitle"].string() in APP_TABLE:

            val =  active["initialTitle"].string()
            print(val)
            menu = APP_TABLE[active["initialTitle"].string()]
        else:
            for app in APP_TABLE.keys():
                if active["initialClass"].string() in app:
                    return APP_TABLE[app]
                elif active["initialTitle"].string() in app:
                    return APP_TABLE[app]
                    break
        return menu
    except:
        return "quick_menu"


fn hyprmenu(get_window: Bool = False) -> None:
    ANYRUN_STDIO: String = (
        "| anyrun --plugins libstdin.so --show-results-immediately true"
        " --max-entries 5 "
    )
    HOME = getenv("HOME")
    if get_window:
        _menu = get_active_window()
        _menu_path: Path = (
            Path(HOME)
            .joinpath(".config/hypr/hyprmenu/")
            .joinpath(_menu)
            .joinpath(".txt")
        )
    else:
        _menu_path: Path = Path(HOME).joinpath(
            ".config/hypr/hyprmenu/quickmenu.txt"
        )
    try:
        with open(_menu_path, "r") as buff:
            selected_cmd = run("echo " + "'" + buff.read() + "'" + ANYRUN_STDIO)
        run(selected_cmd)
    except:
        print("No menu found for this window")


fn main() -> None:
    if len(argv()) <= 1:
        hyprmenu(True)
    else:
        hyprmenu()
