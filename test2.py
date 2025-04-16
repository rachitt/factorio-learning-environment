import time
from eval.open.independent_runs.trajectory_runner import create_factorio_instance
from game_types import Resource
from entities import Position

def main():
    instance = create_factorio_instance(0)
    print(" Connected to Factorio instance")

    for i in range(5):
        # Mine iron ore
        iron_pos = instance.namespace.nearest(Resource.IronOre)
        instance.namespace.move_to(iron_pos)
        print(f"🔨 Mining iron at {iron_pos}")
        instance.namespace.harvest_resource(iron_pos, 3)

        # Mine coal
        coal_pos = instance.namespace.nearest(Resource.Coal)
        instance.namespace.move_to(coal_pos)
        print(f" Mining coal at {coal_pos}")
        instance.namespace.harvest_resource(coal_pos, 2)

        # Print inventory
        inv = instance.namespace.inspect_inventory()
        print(f" Inventory after loop {i+1}: {inv}")

        # Sleep for a moment to let the game render movement
        time.sleep(2)

    print("✅ Demo complete.")

if __name__ == "__main__":
    main()
