def render(line):
    s = " "
    for cell in line.cells:
        if cell.is_alive():
            s += "a"
        else :
            s += "d"

