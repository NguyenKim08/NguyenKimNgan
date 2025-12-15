def render (grid):
    for i in range(grid.m):
        ligne = " "
        for j in range(grid.n):
            cell = grid.Cell[i][j]
            if cell.state == ("alive"):
                ligne += "a"
            elif cell.state == ("dead"):
                ligne += "d"
            else:
                ligne += "b"
            