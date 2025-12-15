class simulation:
    def __init__(self, pop, model):
        self.pop = pop
        self.model = model
        self.t = 0
        self.history = {
            "S": [pop.S],
            "I": [pop.I],
            "R": [pop.R],
        }

    def step(self):
        dI = self.model.new_infections(self.pop)
        dR = self.model.new_recoveries(self.pop)

        self.pop.step(dI, dR)
        self.t += 1

        # ICI ! Il faut self.pop.S, pas S
        self.history["S"].append(self.pop.S)
        self.history["I"].append(self.pop.I)
        self.history["R"].append(self.pop.R)

    def run(self, T):
        for _ in range(T):
            self.step()
