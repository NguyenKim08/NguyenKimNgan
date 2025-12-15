# forest.py

class Forest:
    def __init__(self, N):
        self.N = N
        # grille NxN remplie d'arbres
        self.grid = [["tree" for _ in range(N)] for _ in range(N)]

    def ignite(self, i, j):
        """Mettre le feu à la cellule (i,j)."""
        self.grid[i][j] = "fire"

    def set_empty(self, i, j):
        """Transformer la cellule (i,j) en cendre."""
        self.grid[i][j] = "empty"

    def neighbors(self, i, j):
        """Renvoie les voisins (haut, bas, gauche, droite) de (i,j)."""
        N = self.N
        neigh = []

        # haut
        if i > 0:
            neigh.append((i - 1, j))
        # bas
        if i < N - 1:
            neigh.append((i + 1, j))
        # gauche
        if j > 0:
            neigh.append((i, j - 1))
        # droite
        if j < N - 1:
            neigh.append((i, j + 1))

        return neigh
