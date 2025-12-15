class firemodel:
    def __init__(self,p_lightning):
        self.p_lightning = p_lightning

    def will_burn(self,forest,i,j):
         # Règle 1 : foudre
        if random.random() < self.p_lightning:
            return True

        # Règle 2 : voisin en feu
        for (x, y) in forest.neighbors(i, j):
            if forest.grid[x][y] == "fire":
                return True

        return False



            


