# population.py

class Population:
    def __init__(self, S, I, R):
        # attributs de l'objet
        self.S = S
        self.I = I
        self.R = R
        self.N = S + I + R   # total

    def step(self, dI, dR):
        # mise à jour
        self.S -= dI
        self.I += dI
        self.I -= dR
        self.R += dR

    def fractions(self):
        return self.S / self.N, self.I / self.N, self.R / self.N
