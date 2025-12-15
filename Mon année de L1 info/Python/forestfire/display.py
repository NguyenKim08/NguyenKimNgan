# display.py

def show(forest):
    """Affiche la forêt en ASCII dans le terminal."""
    symbols = {
        "tree": "T",
        "fire": "F",
        "empty": "."
    }

    for row in forest.grid:
        line = "".join(symbols[state] for state in row)
        print(line)
    print()  # ligne vide pour séparer les étapes
