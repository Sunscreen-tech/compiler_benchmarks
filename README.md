# FHE compiler benchmarks
In this repo, we provide benchmarking code for various FHE compilers and instructions for running these benchmarks. Our guide supposes you're using AWS Linux, but these instructions can be modified for other distributions as well.

These benchmarks are used as part of [our paper](https://eprint.iacr.org/2025/1144.pdf) on the Parasol compiler. To use Parasol, you can get started [here](https://docs.sunscreen.tech/install.html). 

We ran the benchmarks on an AWS c7a.16xlarge instance, as sufficient cores are needed to take advantage of parallelism in our approach. If you'd like to view the results we obtained (as of June 2025), feel free to see the evaluation section of our paper or jump to the [performance section in our compiler docs](https://docs.sunscreen.tech/perf.html).

Our benchmarks consist of the following 4 programs:
- **Chi-squared test** (an FHE-friendly variant). This program gives you a sense of how the FHE compilers perform on arithmetic-heavy programs. 
- **Cardio program**. This program contains a mix of operations including logical, comparison, and arithmetic operations. The original program is courtesy of [this SoK paper](https://arxiv.org/abs/2101.07078), as is the variant of chi-squared described above. 
- **First-price sealed-bid auction** (can vary the number of bids). This program features comparisons over encrypted values and looping over plaintext values. Importantly, it features a significant amount of parallelism for Parasol to exploit, assuming the machine has sufficient cores.
- **Hamming distance** (can choose byte size). This program has less parallelism for Parasol to exploit today (e.g. no parallel tree reduction). 

# Prereqs
## Submodules
First, update all submodules to pull down all the other benchmarks:
```bash
git submodule update --init --recursive
```

## Docker
Many of the benchmarks need Docker, which you'll need to either get from your package
manager.

## System deps
You'll need a C++ compiler and OpenSSL (don't ask).

```
sudo yum install -y clang openssl-devel python pip cmake
```

## AVX-512F
Some benchmarks require an x86_64 processor with AVX-512F. If you see "Illegal Instruction" when running one of these benchmarks, you aren't running on such a processor.

You can readily lease such a machine in AWS, notably c7a.* and hpc7a.* EC2 instance types.

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
Install the [Rust](https://rustup.rs/) by following the linked directions.

### Basic op runtimes
To get the runtimes of basic operations running under circuit bootstrapping:

```bash
cd parasol/parasol_runtime
cargo bench --bench ops
```

### Benchmarks
To run the benchmarks we cite in our paper:

```bash
cd parasol/parasol_cpu
cargo bench
```

## Concrete
See [RUNNING.md](https://github.com/Sunscreen-tech/concrete-chisq/blob/main/RUNNING.md).

To change the auction size, edit `concrete/auction.py` and change `num_bids`.

To change the Hamming distance code word size, edit `concrete/hamming.py` and change the `num_bytes`.

## Juliet
See [RUNNING.md](https://github.com/Sunscreen-tech/Juliet/blob/sunscreen_bench/RUNNING.md).

Note our benchmarks are in `juliet_benchmarks/src`.
Furthermore, the mentioned `HEJava-compiler` is already cloned as a submodule in `juliet_compiler`.

We have already compiled, emplaced, and patched the asm files under `juliet/cloud_enc/Benchmarks` so you don't have to.

You'll need to run `keygen` one time.

### Chisq notes
In `juliet/client/preAux.txt`, put 3 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 16.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/ChiSq.asm", 16, 64)
```

### Cardio notes
In `juliet/client/preAux.txt`, put 10 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 8.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/Cardio.asm", 8, 64)
```

### Hamming notes
In `juliet/client/preAux.txt`, put 8 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 8.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/Hamming.asm", 8, 64)
```

In `juliet/cloud_enc/tapes/pub.txt`, write the codeword size (in bytes) you want to evaluate.

### Auction
In `juliet/client/preAux.txt`, put 32 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 16.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/Auction.asm", 16, 64)
```

In `juliet/cloud_enc/tapes/pub.txt`, write the number of bids.

## Google transpiler
See [Running.md](https://github.com/rickwebiii/fully-homomorphic-encryption/blob/main/RUNNING.md).

To change the size of the auction, edit `google_transpiler/transpiler/examples/auction/auction_circuit.h` and change the `NUM_BIDS` define.

To change the Hamming distance code word size, edit `google_transpiler/transpiler/examples/hamming_distance/hamming_distance_circuit.h` and change the `SIZE` define.

## E3
```bash
cd SoK/E3
docker build -t e3 .
docker run -it --entrypoint bash e3
./docker-entrypoint.sh
```

In the hamming distance benchmark, you can change the `SIZE` define in `SoK/E3/source/hamming-tfhe/main.cpp` to change the size of the codewords.

In the auction benchmark, you can change the `COUNT` define in `SoK/E3/source/auciton-tfhe/main.cpp` to change the number of bids.

## Cingulata
```bash
cd SoK/Cingulata
docker build -t cingulata .
docker run -it --entrypoint bash cingulata
./docker-entrypoint.sh
```

In the hamming distance benchmark, you can change the `SIZE` define in `SoK/Cingulata/source/hamming-cingulata-tfhe/hamming-tfhe.cxx` to change the size of the codewords.

In the auction benchmark, you can change the `COUNT` define in `SoK/Cingulata/source/auction-cingulata-tfhe/auction-tfhe.cxx` to change the number of bids.
