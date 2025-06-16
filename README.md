# FHE Compiler Benchmarks
Benchmarks for various FHE compilers and instruction for running them.

# Prereqs
First, update all submodules to pull down all the other benchmarks:
```bash
git submodule update --init --recursive
```

# Running benchmarks
We provide benchmarks for the following TFHE-based frameworks:
* Parasol
* Cingulata
* E3
* Juliet
* Concrete
* Google transpiler

## Parasol
### Prereqs
Install the [Rust](https://rustup.rs/) by following he linked directions.

### Basic op runtimes
To get the runtimes of basic operations running under circuit bootstrapping:

```bash
cd parasol/parasol_runtime
cargo bench --bench ops
```

### Benchmarks
```bash
cd parasol/parasol_cpu
cargo bench
```

## Concrete