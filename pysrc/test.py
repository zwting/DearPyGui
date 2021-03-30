from dearpygui.core import *
from dearpygui.simple import *

def btn_func(*args):
    print(set_label("test", "hello"))

with window("test_window"):

    add_button("hello", callback=btn_func)

start_dearpygui()