# simulation.py

from forest import Forest
from firemodel import FireModel

class Simulation:
    def __init__(self, forest, model):
        self.forest = forest
        self.model = model

    def step(self):
        N = self.forest.N
        # nouvelle grille NxN
        new_grid = [["" for _ in range(N)] for _ in range(N)]

        for i in range(N):
            for j in range(N):
                state = self.forest.grid[i][j]

                if state == "tree":
                    # on demande au modèle si cet arbre doit brûler
                    if self.model.will_burn(self.forest, i, j):
                        new_grid[i][j] = "fire"
                    else:
                        new_grid[i][j] = "tree"

                elif state == "fire":
                    # un feu devient cendre
                    new_grid[i][j] = "empty"

                else:
                    # empty reste empty
                    new_grid[i][j] = "empty"

        # on remplace l'ancienne grille par la nouvelle
        self.forest.grid = new_grid

    def run(self, T):
        for _ in range(T):
            self.step()
