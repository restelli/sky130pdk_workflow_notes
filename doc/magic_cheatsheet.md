# Magic layout editor cheatsheet
## Window menu
- Set grid: important to use this tool often to work with a sane grid every time. By default Sky130 rc file sets a small grid

## Cell Menu
- Place Instance (inserts a cell from file at the location of the current box bottom left corner)

## Spacebar
The spacebar changes the mode of operation across these modes (or more precisely Tools):

|BOX|WIRING|NETLIST|PICK|
|---|------|-------|----|

On each tool it is possibile to perform a bunch of actions:
### Box

|Key combination|Action|Notes|
|---------------|------|-----|
|Left-clk |sets lower left corner of box | |
|Right-clk|sets upper right corner of box| |
|Scroll| pans left/right|
|Shift-scroll| pans up/dwn| |
|z | zooms box|
|Ctrl-z | Zooms in| |
|Shift-Z| Zooms out| |
|f | Zoom full view| also v should work |
|/ | toggle expand|
|Ctrl-X| also toggles expand|
|b and B| navigate through hierarchy... necessary for expansion sometimes|
|Shift-F| expand|
|Ctrl-f | unexpand |
|u | undo| |
|Shift-U| redo| |
|s | select| select boxes that are part of the design|
|b | measure box| it is useful to measure part of design. Options>>Window command entry must be checked to use this feature|
|i | place instance | inserts a cell from file at the location of the current box bottom left corner |
|g |toggle grid| the [grid command](http://opencircuitdesign.com/magic/commandref/grid.html) has several options "grid box" or "grid what" for example tells what is the current grid size in internal units|
|c | copy| it takes the current selection and copies it in the current location of the cursor (origin is bottom left point)|
| ARROWS | moving an object|
|Ctrl-ARROWS| precisely moving by lambda I guess...|
|d | delete





