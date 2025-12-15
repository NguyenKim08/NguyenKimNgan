# main.py

from population import Population
from model import SIRModel
from simulation import simulation


def main():
    N = 1000
    I0 = 10
    R0 = 0
    S0 = N - I0 - R0

    beta = 0.3
    gamma = 0.1

    pop = Population(S0, I0, R0)
    model = SIRModel(beta, gamma)
    sim = simulation(pop, model)

    T = 160
    sim.run(T)

    print("Derniers résultats :")
    print("S =", sim.history["S"][-1])
    print("I =", sim.history["I"][-1])
    print("R =", sim.history["R"][-1])

    pic = max(sim.history["I"])
    print("Pic infectés :", pic)


if __name__ == "__main__":
    main()
