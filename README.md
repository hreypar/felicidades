# Snakemake workflow: `felicidades`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/<owner>/<repo>/actions?query=branch%3Amain+workflow%3ATests)


A Snakemake workflow for `plotting a birthday cake for your friends in their special day`

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

tree results # or ls results

```


