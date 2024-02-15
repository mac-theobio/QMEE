---
title: "Meaningful, interpretable and comparable estimates"
author: "Ian Dworkin"
---

Introduction
============

Getting the computer to fit a linear model is relatively straightforward. Spending the time and making sure  what you plan to do is **meaningful** with respect to the measurements you have used, making your model estimates (coefficients) **interpretable** to help you understand the model output, and determining the best measures of effect to make your results **comparable** within your model, and to other estimates in the scientific literature is a key part of this. 

 In some sense the whole week  is to get you to  focus on the question *"What is the difference?"* (or "what are the differences?"), and to make sure the differences (and their associated uncertainties) are meaningful, interpretable and comparable. This is generally much better than asking questions like "Is there a difference?" ("are there differences?"). These latter questions are often much less useful, and more likely to result in bad habits in terms of data modeling, statistical inference and using these to answer biological questions.

Goals for this week
===================

- Making estimates meaningful: What you measure, and how it impacts how you model data, and derive meaning from model estimates.

- Making estimates interpretable: How simple “transformations” like mean-centring and standardization (z-transformation) predictor variables can aid in interpretation.

- Making estimates comparable: How to make your model estimates (coefficients) both within your experiment, and (hopefully) to enable meaningful comparisons with the broader literature.


Class materials
===============

-   [slides on measurement theory](../lectures/BIO708_Measurement_and_Meaning.pdf)
-   [script for interpretability](../lectures/Intepreting_lm_output_Feb13_2024_short.html)
-   [slides on effect sizes](../lectures/BIO708_EffectSizes_Svelte.pdf)
-   [script for effect sizes](../lectures/BIO708_EffectSizes.html)


Resources
=========
-   Introductory
    -   [Voje et al. 2023](https://doi.org/10.1016/j.tree.2023.08.005) on representational measurement theory and meaning(**N**ominal, **O**rdinal, **I**nterval, **R**atio)
    -   [Schielzeth](https://doi.org/10.1111/j.2041-210X.2010.00012.x) (2010)
        on centering and scaling in linear models (interpretability)
     -   [Nakagawa and Cuthill 2007](https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1469-185X.2007.00027.x) on effect sizes (and their confidence intervals) and how to make good use of them in biology (comparability)
   -   [Open source book on effect sizes, with examples in R](https://matthewbjane.quarto.pub/). Also useful chapter on benchmarking in this.
   -   [Watch this video by Megan Higgs](https://www.youtube.com/watch?v=eJI0kNXmonk) which discusses benchmarking (critical stuff at about 8:40 in)

Assignment
==========

TBD
