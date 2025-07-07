# FHE compiler benchmarks
In this repo, we provide benchmarking code for various FHE compilers and instructions for running these benchmarks. Our guide supposes you're using AWS Linux, but these instructions can be modified for other distributions as well.

These benchmarks are used as part of [our paper](https://eprint.iacr.org/2025/1144.pdf) on the Parasol compiler. To use Parasol, you can get started [here](https://docs.sunscreen.tech/install.html). 

Our benchmarks consist of the following 4 programs:
- **Chi-squared test** (an FHE-friendly variant). This program gives you a sense of how the FHE compilers perform on arithmetic-heavy programs. 
- **Cardio program**. This program contains a mix of operations including logical, comparison, and arithmetic operations. The original program is courtesy of [this SoK paper](https://arxiv.org/abs/2101.07078), as is the variant of chi-squared described above. 
- **First-price sealed-bid auction** (can vary the number of bids). This program features comparisons over encrypted values and looping over plaintext values. Importantly, it features a significant amount of parallelism for Parasol to exploit, assuming the machine has sufficient cores.
- **Hamming distance** (can choose byte size). This program has less parallelism for Parasol to exploit today (e.g. no parallel tree reduction). 

We ran the benchmarks on an AWS c7a.16xlarge instance, as sufficient cores are needed to take advantage of parallelism in our approach. 

Feel free to jump to the relevant section:
- [Setup](#setup)
- [Running the benchmarks](#running-the-benchmarks)
- [Results](#our-results)

## Setup
### Submodules
First, update all submodules to pull down all the other benchmarks:
```bash
git submodule update --init --recursive
```

### Docker
Many of the benchmarks need Docker, which you'll need to either get from your package
manager.

### System deps
You'll need a C++ compiler and OpenSSL (don't ask).

```
sudo yum install -y clang openssl-devel python pip cmake
```

### AVX-512F
Some benchmarks (specifically Cingulata and E3) require an x86_64 processor with AVX-512F. If you see "Illegal Instruction" when running one of these benchmarks, you aren't running on such a processor.

You can readily lease such a machine in AWS, notably c7a.* and hpc7a.* EC2 instance types.

## Running the benchmarks
We provide benchmarks for the following TFHE-based frameworks:
* Parasol
* Cingulata
* E3
* Juliet
* Concrete
* Google transpiler

Using [Lattice Estimator](https://github.com/malb/lattice-estimator), we estimate Parasol and Concrete to provide ~128 bits of security; Google, Cingulata, and Juliet provide ~118 bits; E3 provides ~94 bits.

If you'd like to find more information about the parameters used in Parasol, feel free to take a look [here](https://github.com/Sunscreen-tech/spf/blob/main/parasol_runtime/src/params.rs) and [here](https://github.com/Sunscreen-tech/spf/blob/main/sunscreen_tfhe/src/params.rs).

### Parasol
#### Prereqs
Install the [Rust](https://rustup.rs/) by following the linked directions.

#### Basic op runtimes
To get the runtimes of basic operations running under circuit bootstrapping:

```bash
cd parasol/parasol_runtime
cargo bench --bench ops
```

#### Benchmarks
To run the benchmarks we cite in our paper:

```bash
cd parasol/parasol_cpu
cargo bench
```

### Concrete
See [RUNNING.md](https://github.com/Sunscreen-tech/concrete-chisq/blob/main/RUNNING.md).

To change the auction size, edit `concrete/auction.py` and change `num_bids`.

To change the Hamming distance code word size, edit `concrete/hamming.py` and change the `num_bytes`.

### Juliet
See [RUNNING.md](https://github.com/Sunscreen-tech/Juliet/blob/sunscreen_bench/RUNNING.md).

Note our benchmarks are in `juliet_benchmarks/src`.
Furthermore, the mentioned `HEJava-compiler` is already cloned as a submodule in `juliet_compiler`.

We have already compiled, emplaced, and patched the asm files under `juliet/cloud_enc/Benchmarks` so you don't have to.

You'll need to run `keygen` one time.

#### Chisq notes
In `juliet/client/preAux.txt`, put 3 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 16.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/ChiSq.asm", 16, 64)
```

#### Cardio notes
In `juliet/client/preAux.txt`, put 10 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 8.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/Cardio.asm", 8, 64)
```

#### Hamming notes
In `juliet/client/preAux.txt`, put 8 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 8.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/Hamming.asm", 8, 64)
```

In `juliet/cloud_enc/tapes/pub.txt`, write the codeword size (in bytes) you want to evaluate.

#### Auction
In `juliet/client/preAux.txt`, put 32 values, 1 per line.
In `juliet/client/ppscript.sh` change `WORDSIZE` to 16.

In `juliet/cloud_end/juliet_interpreter.py`, update the second to last line:

```python
juliet_ee("Benchmarks/Auction.asm", 16, 64)
```

In `juliet/cloud_enc/tapes/pub.txt`, write the number of bids.

### Google transpiler
See [Running.md](https://github.com/rickwebiii/fully-homomorphic-encryption/blob/main/RUNNING.md).

To change the size of the auction, edit `google_transpiler/transpiler/examples/auction/auction_circuit.h` and change the `NUM_BIDS` define.

To change the Hamming distance code word size, edit `google_transpiler/transpiler/examples/hamming_distance/hamming_distance_circuit.h` and change the `SIZE` define.

### E3
```bash
cd SoK/E3
docker build -t e3 .
docker run -it --entrypoint bash e3
./docker-entrypoint.sh
```

In the hamming distance benchmark, you can change the `SIZE` define in `SoK/E3/source/hamming-tfhe/main.cpp` to change the size of the codewords.

In the auction benchmark, you can change the `COUNT` define in `SoK/E3/source/auciton-tfhe/main.cpp` to change the number of bids.

### Cingulata
```bash
cd SoK/Cingulata
docker build -t cingulata .
docker run -it --entrypoint bash cingulata
./docker-entrypoint.sh
```

In the hamming distance benchmark, you can change the `SIZE` define in `SoK/Cingulata/source/hamming-cingulata-tfhe/hamming-tfhe.cxx` to change the size of the codewords.

In the auction benchmark, you can change the `COUNT` define in `SoK/Cingulata/source/auction-cingulata-tfhe/auction-tfhe.cxx` to change the number of bids.

## Our results
Full details can be found in [our paper](https://eprint.iacr.org/2025/1144.pdf).

Juliet seems to experience some issues at 8-bit precision. For Concrete, which asks for sample inputs from the developer, we pass in inputs of the same bit size needed to maintain the precision used by other frameworks (except for cardio program as the output is a small integer anyway).

### Chi-squared program
We look at how our compiler performs for a FHE-friendly variant of chi-squared with respect to runtime of the generated FHE program, size of the compiler output, and memory usage.

| Compiler           | Runtime   | Program size | Memory usage |
| ------------------ | --------- | ------------ | ------------ |
| Parasol            | **576ms** | **232B**     | 365MB        |
| Concrete           | 5.29s     | 1.41kB       | 1.82GB       |
| Google Transpiler  | 13.8s     | 323kB        | 299MB        |
| E<sup>3</sup>-TFHE | 440s      | 2.87MB       | **182MB**    |
| Cingulata-TFHE     | 85.6s     | 579kB        | 254MB        |
| Juliet             |  114s      |  512B       |  254MB       |


### Cardio program
We also consider how our compiler performs for the cardio program with respect to runtime of the generated FHE programs, size of the compiler output, and memory usage.

| Compiler           | Runtime   | Program size | Memory usage |
| ------------------ | --------- | ------------ | ------------ |
| Parasol            | **438ms** | **472B**     | 399MB        |
| Concrete           | 2.13s     | 10.4kB       | 4.0GB        |
| Google Transpiler  | 3.26s     | 11.4kB       | 274MB        |
| E<sup>3</sup>-TFHE | 119s      | 1.87MB       | **181MB**    |
| Cingulata-TFHE     | 2.98s     | 613kB        | 254MB        |
| Juliet             | N/A       | N/A    | N/A    |

### First-price sealed-bid auction
We also consider how our compiler performs with respect to runtime of the generated FHE program as we vary the number of bids.

|                    |     2 bids    |       4 bids     |        8 bids     |     16 bids   |     32 bids     |
| ------------------ | ------------- | ---------------- | ----------------- | ------------- | --------------- |
| Parasol            |   **0.098s**  |     **0.275s**   | **0.625s**        |   **1.315s**  |   **2.714s**    |
| Concrete           | 24.1s         | 86.4s            | 264s              |    694s       |   1690s         |
| Google Transpiler  | 2.36s         | 6.72s            | 15.4s             |    33.1s      |    68.2s        |
| E<sup>3</sup>-TFHE | 12.4s         | 36.6s            | 84.8s             |     182s      |    379s         |
| Cingulata-TFHE     | 1.48s         | 4.33s            | 10.3s             |    22.4s      |     47.2s       |
| Juliet             | 5.54s         |   16.6s          | 38.7s           |    82.7s       |  171s            |

### Hamming distance between 2 N-byte words

|                    |    1 byte    |       2 bytes    |        4 bytes     |     8 bytes   |
| ------------------ | ------------- | ---------------- | ----------------- | ------------- | 
| Parasol            |   **0.339s**  |     **0.681s**   | **1.36s**        |   **2.7s**  |
| Concrete           | 4.89s         | 7.74s            | 12.3s              |    24.7s       |
| Google Transpiler  | 4.12s         | 9.60s            | 19.7s             |    40.2s      |
| E<sup>3</sup>-TFHE | 33.8s         | 68.4s            | 135s             |     268s      |
| Cingulata-TFHE     | 1.48s         | 4.19s            | 9.59s             |    20.2s      |
| Juliet     | N/A         |   8.89s          | 18.2s            |    36.1s      |
