# display.py

def show(grid):
    """Affiche la grille du Game of Life."""
    for row in grid.grid:
        line = "".join("#" if cell == 1 else "." for cell in row)
        print(line)
    print()
