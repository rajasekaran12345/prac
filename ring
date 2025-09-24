class RingAlgorithm:
    def __init__(self, processes):
        self.processes = sorted(processes)  # Sorted list of process IDs
        self.n = len(processes)

    def start_election(self, initiator):
        print(f"\nElection started by process {initiator}")
        if initiator not in self.processes:
            print(f"Process {initiator} not found!")
            return
        
        index = self.processes.index(initiator)
        message = [initiator]

        # Pass message around the ring
        for i in range(1, self.n):
            next_process = self.processes[(index + i) % self.n]
            message.append(next_process)
            print(f"Process {message[-2]} sends message to {next_process}")

        # Determine coordinator (highest ID)
        coordinator = max(message)
        print(f"\nElection complete. New coordinator is Process {coordinator}\n")

        # Announce coordinator
        for i in range(self.n):
            sender = self.processes[i]
            receiver = self.processes[(i + 1) % self.n]
            print(f"Process {sender} informs {receiver}: Coordinator is {coordinator}")


# Example Usage
if __name__ == "__main__":
    processes = [1, 3, 5, 7, 9]  # Unique IDs
    ring = RingAlgorithm(processes)

    ring.start_election(3)  # Start election from process 3
