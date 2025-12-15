import random

def binomial(n, p):
    """
    Sample from Binomial(n, p).
    """
    count = 0
    for _ in range(n):
        if random.random() < p:
            count += 1
    return count

class SIRModel:

    def __init__(self,beta, gamma):
        self.beta = beta      
        self.gamma = gamma 

    def new_infections(self,pop):
        rp = self.beta * pop.I / pop.N
        return binomial(pop.S, rp)
    
    def new_recoveries(self,pop):
        rp = self.gamma
        return binomial(pop.I, rp)
    
    

    
