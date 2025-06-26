from time import now
from sys import external_call
from python import Python

fn benchmark_startup():
    let start_time = now()
    
    # Run the application using external_call
    let result = external_call["mojo", String("hyprmenu.mojo")]()
    
    let end_time = now()
    let startup_time = (end_time - start_time) / 1_000_000_000  # Convert nanoseconds to seconds
    
    print("Startup time:", startup_time, "seconds")

fn main():
    benchmark_startup()
