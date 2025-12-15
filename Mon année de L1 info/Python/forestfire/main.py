# main.py

from forest import Forest
from firemodel import FireModel
from simulation import Simulation
import display
import time

def main():
    # taille de la forêt
    N = 20

    # création des objets principaux
    forest = Forest(N)
    model = FireModel(p_lightning=0.01)
    sim = Simulation(forest, model)

    # on allume un feu au centre
    forest.ignite(N // 2, N // 2)

    # nombre d'étapes de la simulation
    T = 50

    for _ in range(T):
        display.show(forest)  # afficher l'état actuel
        sim.step()            # avancer d'un pas
        time.sleep(0.1)       # petite pause pour voir l'évolution

if __name__ == "__main__":
    main()
