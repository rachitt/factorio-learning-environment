import random
import time
from eval.open.independent_runs.trajectory_runner import create_factorio_instance

# Simple Position class
class Position:
    def __init__(self, x, y):
        self.x = x
        self.y = y

def main():
    instance = create_factorio_instance(0)
    print("Connected. Starting random walk...")

    pos = Position(0, 0)

    for _ in range(100):  # Number of steps
        dx, dy = random.choice([(1,0), (-1,0), (0,1), (0,-1)])  # NESW
        pos = Position(pos.x + dx, pos.y + dy)
        instance.namespace.move_to(pos)
        time.sleep(0.2)  # Lower this to move faster

    print("Random walk complete.")

if __name__ == "__main__":
    main()
