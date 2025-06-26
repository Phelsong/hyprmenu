import subprocess
import time

def benchmark_startup():
    start_time = time.time()

    # Run the application
    subprocess.run(["mojo", "hyprmenu.mojo"])

    end_time = time.time()
    startup_time = end_time - start_time
    print(f"Startup time: {startup_time:.4f} seconds")

if __name__ == "__main__":
    benchmark_startup()
