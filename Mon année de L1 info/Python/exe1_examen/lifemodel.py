# lifemodel.py

class LifeModel:
    def next_state(self, grid, i, j):
        """Détermine l'état futur de la cellule (i,j)."""

        alive = grid.grid[i][j]
        neighbors = grid.neighbors_alive(i, j)

        # Règles de Conway
        if alive == 1:
            # Survie
            if neighbors == 2 or neighbors == 3:
                return 1
            else:
                return 0
        else:
            # Naissance
            if neighbors == 3:
                return 1
            else:
                return 0
