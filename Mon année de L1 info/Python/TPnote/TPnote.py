class Cell:
    def __init__(self,state: str):
        state = ["dead","alive","border"]
        state = self.state
    
    def is_alive(self):
        return self.state == "alive"
    
    def set_state(state):
        if self.state == "border":
            return Cell ("border")
        elif self.state == "alive":
            return Cell ("alive")
        else:
            return Cell("dead")

class Line:
    def __init__(self, n: int):
        """Create a Line of n Cells. The first cell is a border cell; the rest are dead by default."""
        self.n = int(n)
        self.cells = []
        for i in range(self.n):
            if i == 0:
                self.cells.append(Cell("border"))
            else:
                self.cells.append(Cell("dead"))

    def set_alive(self, i: int):
        """Set the cell at index i to alive (if in range)."""
        if 0 <= i < self.n:
            self.cells[i] = Cell("alive")
    
    def get(self, i: int):
        """Return the Cell at index i; if out-of-range return a border cell."""
        if i < 0 or i >= self.n:
            return Cell("border")
        return self.cells[i]
    def copy(self):
        """Return a copy of this Line (new Line with copied Cell states)."""
        new_line = Line(self.n)
        new_line.cells = [Cell(c.state) for c in self.cells]
        return new_line
    
