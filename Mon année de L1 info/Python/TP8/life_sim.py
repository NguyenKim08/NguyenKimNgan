class Cell:
    def __init__(self,state):
        state = ["alive","dead","border"]
        state = self.state
    
    def is_alive(self):
        return self.state == ("alive")
    
    def update(self,nb):
        if self.state == ("border"):
            return Cell("border")
        if self.state == ("alive"):
            if nb == 2 or nb == 3:
                return self.state == ("alive")
        elif self.state == ("dead"):
            if nb == 3:
                self.state == ("alive")
        else:
            return self.state == ("dead")
        
    class Grid:
        def __init__(self,m,n):
            m = self.m
            n = self.n
            self.cells = [] #a place (list) to store line that contained cells
            for i in range(n):
                ligne = [] #une ligne 
                if i == 0 or i == m-1 or j == 0 or j == n-1:
                    ligne.append(Cell("border"))
                else:
                    ligne.append(Cell("dead"))
            self.cells.append(ligne) #append la ligne dans cells

        def set_alive(self,x, y):
            if 0 < x < self.m - 1 and 0 < y < self.n - 1:
                self.cells [x] [y] == Cell("alive")

        def get(self,x,y):
            return self.cells [x][y]
        def nb_neighbor_alive(grid,x,y):
            alive = 0
            for dx in [-1,0,1]:
                if dx == 0 and dy == 0:
                    continue
            nx, ny = x + dx, y + dy
            if 0 <= nx < grid.m and 0 <= ny < grid.n:
                alive += 1
            return alive 
        def update_all(grid):
            new_cells = []
            for i in range(grid.m):
                ligne = []
                for j in range(grid.n):
                    n = nb_neighbor_alive(grid, i,j)
                    ligne.append(cell.update(n))
                    new_cells.append(ligne)
                grid.cells = new_cells

                     


        
