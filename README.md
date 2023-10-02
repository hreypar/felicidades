# Snakemake workflow: `felicidades`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/<owner>/<repo>/actions?query=branch%3Amain+workflow%3ATests)


A Snakemake workflow that plots a birthday cake for your friends in their special day.

## Overview

This workflow takes as input a friends csv table with their names and dates of birth. The workflow "bakes" (plots) a cake using R if `today()` is the person's birthday (or if the dob is within +/- 3 days of `today()`. Otherwise, it plots an ice cream for the person as a consolation prize. 


## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=<owner>%2F<repo>).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) <repo>sitory and its DOI (see above).

## Prerequisites

- Conda ([Miniconda](https://docs.conda.io/projects/miniconda/en/latest/) or [Anaconda](https://www.anaconda.com/download)). Conda is a package manager that can manage dependencies and environments for your workflow. If you don't have Conda installed, you can install Miniconda (a minimal Conda installer) or Anaconda (a full Conda installer with additional data science packages). My personal preference is Miniconda.

- [Mamba]( https://github.com/mamba-org/mamba) (Optional, but recommended for faster environment management). Mamba is a drop-in replacement for the Conda package manager that offers significantly faster environment resolution and dependency handling. It can be used interchangeably with Conda commands. To install Mamba, first ensure you have Conda installed (either Miniconda or Anaconda). Then, create a Conda environment and install Mamba using the following commands:

```
conda install -n base -c conda-forge mamba
```

- [Snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html): a workflow management system that allows you to create reproducible and scalable data analyses. Install Snakemake using Conda to ensure compatibility with your workflow. You can create an environment and install Snakemake with the following commands:

```
conda activate base
mamba create -c conda-forge -c bioconda -n snakemake snakemake
```

## Instructions to use this Workflow

```
# clone this repository 
git clone git@github.com:hreypar/felicidades.git

# change directory into the repo
cd felicidades

# activate snakemake environment
conda activate snakemake

# run workflow on default data 
snakemake --use-conda --cores 2 

# check results
tree results 

# alternatively check results with ls
ls results/celebracion

```

### Use your own data

If you want to congratulate your own friends, you only need to add (or edit) a csv table similar to [`cumpleaneros_octubre.tsv`](https://github.com/hreypar/felicidades/blob/main/config/cumpleaneros_octubre.csv) with your own people's birthdays and update the [`config/config.yaml`](https://github.com/hreypar/felicidades/blob/main/config/config.yaml) file accordingly.


## Project structure

```
.
├── benchmarks                           # Directory for benchmark data
│   └── celebracion
│       └── pastel_Bill.tsv              # Sample benchmark data for celebration
│
├── config                               # Configuration files
│   ├── config.yaml                      # Configuration for the workflow
│   ├── cumpleaneros_octubre.csv          # Input data: October birthdays
│   └── README.md                        # Information about the configuration files
│
├── LICENSE                              # License file for the project
├── README.md                            # Main project README file
│
├── results                              # Directory for generated results
│   └── celebracion
│       ├── felicitaciones_para_Bill.pdf  # Example birthday greeting PDF
│       └── pastel_Bill.log              # Log file for the creation of Bill's pastel
│
└── workflow                             # Workflow-related files
    ├── envs                             # Conda environment files
    │   └── graficar_pastel.yaml         # Environment file for the project
    ├── rules                            # Snakemake rule files
    │   ├── common.smk                   # Rule for common tasks
    │   └── felicitar_con_pastel.smk     # Rule for creating greetings with cakes
    ├── scripts                          # Scripts used in the workflow
    │   └── pastel.R                     # R script for generating cake visualizations
    └── Snakefile                        # Main Snakemake workflow file

```


## Additional Information

What I actually do is Bioinformatics and Computational Biology, particularly analysis of sequencing data (both bulk and single-cell). However, my good friend [Israel Aguilar](https://github.com/Iaguilaror) (also a bioinformatician) has a birthday coming up. [Reproducible code](https://en.wikipedia.org/wiki/Reproducibility) is one of his favorite things in the world, and he's a pro creating workflows with [Nextflow](https://www.nextflow.io/) but I'm more on the Snakemake side so I thought I'd gift him an excuse to start learning it 🐍.

### Authors

[Helena Reyes-Gopar](https://github.com/hreypar)


### Acknowledgements

This workflow was heavily inspired by [this script](https://qiuyiwu.github.io/2019/01/29/Birthday/) from Qiuyu's Blog.

