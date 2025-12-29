# Kernel PCA and Pre-Image Reconstruction

[![View Kernel PCA and Pre-Image Reconstruction on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/39715-kernel-pca-and-pre-image-reconstruction) 
[![arxiv](https://img.shields.io/badge/PDF-arXiv-yellow.svg)](https://arxiv.org/pdf/1207.3538.pdf)
[![Octave application](https://github.com/wq2012/kPCA/actions/workflows/octave.yml/badge.svg)](https://github.com/wq2012/kPCA/actions/workflows/octave.yml)

## 📑 Table of Contents
- [Overview](#📖-overview)
- [Getting Started](#🚀-getting-started)
    - [Prerequisites](#prerequisites)
    - [Mounting the library](#mounting-the-library)
- [Core Functions](#🛠-core-functions)
- [Demos](#📺-demos)
    - [1. Synthetic Data Embedding](#1-synthetic-data-embedding-demo1)
    - [2. Yale Face Database Classification](#2-yale-face-database-classification-demo2)
    - [3. Face Active Shape Models](#3-face-active-shape-models-demo3)
- [Testing & CI](#🧪-testing--ci)
- [Project Structure](#📂-project-structure)
- [Citations](#📜-citations)

## 📖 Overview

This repository provides a comprehensive implementation of **Principal Component Analysis (PCA)**, **Kernel PCA (kPCA)**, and **pre-image reconstruction** of Gaussian kernel PCA. 

The library is designed for efficiency and has been widely used in research projects involving dimensionality reduction, face recognition, and active shape models.

![pic](resources/kPCA.png)

---

## 🚀 Getting Started

### Prerequisites

This toolbox is compatible with both **GNU Octave** and **MATLAB**.

To run the full suite of demos (specifically `demo2`), you need the `statistics` package.

#### Installing dependencies (Octave)
On Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install octave octave-statistics
```

#### Mounting the library
To use the library in your code, add the `code` directory to your path:
```matlab
addpath('path/to/kPCA/code');
```

---

## 🛠 Core Functions

### [PCA.m](code/PCA.m)
Performs standard Principal Component Analysis.
```matlab
[Y, eigVector, eigValue, explained] = PCA(X, d)
```
- **X**: Data matrix (N x M), each row is an observation.
- **d**: Target reduced dimension.
- **Y**: Dimensionally-reduced data (N x d).
- **explained**: Percentage of variance explained by each component.

### [kPCA.m](code/kPCA.m)
Performs Kernel Principal Component Analysis.
```matlab
[Y, eigVector, eigValue, explained] = kPCA(X, d, type, para)
```
- **type**: Kernel type: `'simple'`, `'poly'`, `'gaussian'`, `'laplacian'`, or `'sigmoid'`.
- **para**: Kernel parameter.

### [kPCA_NewData.m](code/kPCA_NewData.m)
Projects new data points into the kPCA space.
```matlab
Z = kPCA_NewData(Y, X, eigVector, type, para)
```

### [kPCA_PreImage.m](code/kPCA_PreImage.m)
Reconstructs the pre-image of a point in the kPCA space (Gaussian kernel only).
```matlab
z = kPCA_PreImage(y, eigVector, X, para)
```

### Advanced Utilities
- **[estimateSigma.m](code/estimateSigma.m)**: Automatically estimate the Gaussian kernel parameter using the "median trick".
- **[PCA_Inverse.m](code/PCA_Inverse.m)**: Reconstruct original data from PCA components.

---

## 📺 Demos

The repository includes three distinct demos to showcase the capabilities of the library:

### 1. Synthetic Data Embedding (`demo1`)
- **Script**: `demo1/demo_SyntheticData.m`
- **Description**: Demonstrates kPCA on a synthetic dataset consisting of two concentric spheres. It shows how kPCA can effectively unfold non-linear structures that standard PCA fails to capture.

### 2. Yale Face Database Classification (`demo2`)
- **Script**: `demo2/demo_YaleFace.m`
- **Description**: Compares PCA and kPCA for face recognition tasks using a subset of the Yale Face Database B. It calculates error rates on both training and testing datasets.
- **Note**: Requires the `statistics` package for `classify`.

### 3. Face Active Shape Models (`demo3`)
- **Scripts**: `demo3/demo_faceASM_PCA.m`, `demo3/demo_faceASM_kPCA.m`
- **Description**: Demonstrates the application of PCA and kPCA in Active Shape Models (ASM) for face modelling. It visualizes how different eigenvectors capture variations in facial features.

---

## 🧪 Testing & CI

We maintain a suite of unit tests to ensure the reliability of the core functions.

### Running Tests Locally
```bash
cd tests
octave test_distanceMatrix.m
octave test_PCA.m
octave test_kernel.m
octave test_kPCA.m
octave test_new_features.m
octave test_stability.m
```

### Benchmarking
Compare performance between functions:
```bash
octave tests/benchmark_kPCA.m
```

### Continuous Integration (CI)
The project uses GitHub Actions to automatically run all unit tests and demos on every push to the `master` branch. The current status can be seen at the top of this README.

---

## 📂 Project Structure

- `code/`: Core library implementation.
- `demo1/`, `demo2/`, `demo3/`: Thematic demonstration scripts and datasets.
- `tests/`: Unit test suite.
- `resources/`: Documentation assets.

---

## 📜 Citations

If you use this library in your research, please cite our corresponding paper:

```bibtex
@article{wang2012kernel,
  title={Kernel principal component analysis and its applications in face recognition and active shape models},
  author={Wang, Quan},
  journal={arXiv preprint arXiv:1207.3538},
  year={2012}
}
```

---
*Created and maintained by [Quan Wang](https://github.com/wq2012).*
