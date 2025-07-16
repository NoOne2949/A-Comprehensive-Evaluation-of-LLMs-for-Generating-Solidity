# A Comprehensive Evaluation of LLMs for Generating Solidity

This repository contains the code and data for a comprehensive evaluation of Large Language Models (LLMs) for Solidity code generation.

## ⚙️ Setup

Follow these steps to set up your development environment.

1.  Create a virtual environment:

    ```bash
    python -m venv venv
    ```

2.  Activate the virtual environment:

    Windows:

    ```bash
    venv\Scripts\activate
    ```

    macOS/Linux:

    ```bash
    source venv/bin/activate
    ```

3.  Install dependencies:

    Make sure your virtual environment is active, then run:

    ```bash
    pip install -r requirements.txt
    ```

## 📁 Folder Structure

The project structure is organized as follows:

You got it! Here's the English README, formatted in Markdown and ready for you to paste:

Markdown

# A Comprehensive Evaluation of LLMs for Generating Solidity

This repository contains the code and data for a comprehensive evaluation of Large Language Models (LLMs) for Solidity code generation.

## ⚙️ Setup

Follow these steps to set up your development environment.

1.  **Create a virtual environment**:

    ```bash
    python -m venv venv
    ```

2.  **Activate the virtual environment**:

    Windows:

    ```bash
    venv\Scripts\activate
    ```

    macOS/Linux:

    ```bash
    source venv/bin/activate
    ```

3.  **Install dependencies**:

    Make sure your virtual environment is active, then run:

    ```bash
    pip install -r requirements.txt
    ```

## 📁 Folder Structure

The project structure is organized as follows:

* analysis/

* cognitive_complexity/

* data/

* gas_and_functionality/

* preprocess/

* rag/

* scripts/

### analysis/
This folder contains code to get similarity metrics (such as BLEU and TED) and complexity to answer Research Questions (RQ) 1 and 4.

### cognitive_complexity/
This folder contains the code to calculate cognitive complexity.

### data/
This folder contains the ground truth data, and a CSV file `sample_of_interest.csv` with metrics related to the ground truth function, for instance, complexities.

### gas_and_functionality/
This folder contains data, code, and results related to gas consumption and functional correctness assessment.

### preprocess
Add a description for the `preprocess` folder here. 

### rag
Add a description for the `rag/` folder here.

### scripts
Add a description for the `scripts/` folder here.
