from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
    counter = 0  # Class-level counter to alternate stripes

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        if context.in_browser:
            attr = normal

            # Reset counter at start of each redraw cycle
            if context.main_column and not context.selected:
                Default.counter += 1
                if Default.counter > 1000:
                    Default.counter = 0

            # Alternate every other line visually
            if Default.counter % 2 == 0:
                fg = black
                bg = white
            else:
                fg = white
                bg = black

            if context.selected:
                attr |= reverse

            if context.marked:
                attr |= bold
                fg = yellow

        elif context.in_titlebar:
            attr |= bold
            fg = white
            bg = black

        elif context.in_statusbar:
            fg = white
            bg = black
            attr |= normal

        if context.text and context.highlight:
            attr |= reverse

        return fg, bg, attr

