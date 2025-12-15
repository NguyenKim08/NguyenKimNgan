# simulation.py

from grid import Grid
from lifemodel import LifeModel

class Simulation:
    def __init__(self, grid, model):
        self.grid = grid
        self.model = model

    def step(self):
        N = self.grid.N
        # Nouvelle grille vide
        new_grid = [[0 for _ in range(N)] for _ in range(N)]

        for i in range(N):
            for j in range(N):
                new_grid[i][j] = self.model.next_state(self.grid, i, j)

        self.grid.grid = new_grid

    def run(self, T):
        for _ in range(T):
            self.step()
