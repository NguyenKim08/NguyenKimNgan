class Cell:
    def __init__(self,state: str):
        state = ["dead","alive","border"]
        state = self.state

        #we initiate the state of a cell here 
    
    def is_alive(self):
        return self.state == "alive"
    
    #we check if said cell is alive or not

    def set_state(self,state):
        if self.state == "border":
            return Cell ("border")
        elif self.state == "alive":
            return Cell ("alive")
        else:
            return Cell("dead")
        
    #we set the initial state of the cell

class Line:
    def __init__(self, n: int):
        self.n = int(n) #int is for n an integer here 
        self.cells = [] #create a place to store new cells(a list)
        for i in range(self.n):
            if i == 0:
                self.cells.append(Cell("border"))
            else:
                self.cells.append(Cell("dead"))
    #we create a line of n cells, the first one is border i = 0
    #the rest are dead by default

    def set_alive(self, i: int):
        if 0 <= i < self.n: #if in range of self.n (in the number of cells in the line)
            self.cells[i] = Cell("alive")
            #cell à indice i is "alive"
    
    def get(self, i: int):
        if i < 0 or i >= self.n:
            return Cell("border")
        return self.cells[i]
    #if cell [i] out of range then the state of said cell is dead
    #otherwise return the cell in the line (self.cells[i])
    
    def copy(self):
        new_line = Line(self.n) #create a new line
        new_line.cells = [Cell(c.state) for c in self.cells] #and new cells
        return new_line
    #return a copy of the line 
    
    def update_all(line, offset, alive_counts):
        old_line = []
        new_line = []
        for i in range(len(old_line.cells)):
            alive = 0
            for off in offsets:
                neighbor = old_line.get(i + off)
                if neighbor.is_alive():
                    alive += 1
            if alive in alive_counts:
                new_line.cells[i].set_state("alive")
            else:
                new_line.cells[i].set_state("dead")
        return new_line                

    




