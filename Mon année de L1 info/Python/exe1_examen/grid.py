# grid.py

class Grid:
    def __init__(self, N):
        self.N = N
        # Grille NxN de cellules mortes (0)
        self.grid = [[0 for _ in range(N)] for _ in range(N)]

    def set_alive(self, i, j):
        self.grid[i][j] = 1

    def set_dead(self, i, j):
        self.grid[i][j] = 0

    def neighbors_alive(self, i, j):
        """Compte les voisins vivants (8 directions)."""
        N = self.N
        count = 0

        # Liste des déplacements (8 voisins)
        directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),         (0, 1),
            (1, -1),  (1, 0),  (1, 1)
        ]

        for di, dj in directions:
            x, y = i + di, j + dj
            if 0 <= x < N and 0 <= y < N:
                if self.grid[x][y] == 1:
                    count += 1

        return count
