# Adaptive approximate Bayesian computation

## Description

This repository proposes several algorithms used in 
[[1]](http://link.springer.com/article/10.1007%2Fs00180-013-0428-3). 
In this paper, we proposed a new approximate Bayesian computation (ABC) 
algorithm that we compared with three other algorithms: the Population Monte 
Carlo algorithm [[2]](https://academic.oup.com/biomet/article/96/4/983/220502),
the Sequential Monte Carlo algorithm 
[[3]](https://link.springer.com/article/10.1007/s11222-011-9271-y)
and the Replenishement Sequential Monte Carlo algorithm 
[[4]](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1541-0420.2010.01410.x). 
We compare them using the toy example studied in 
[[5]](https://www.pnas.org/content/104/6/1760?ijkey=d09a94d7744324fa718c59a5e96d840d39a67485&keytype2=tf_ipsecsha).

## Scripts

This repository contains an implementation of the four ABC algorithms described 
in the paper,  

* **APMC:** Adaptive population Monte Carlo [[1]](http://link.springer.com/article/10.1007%2Fs00180-013-0428-3)
* **PMC:** Population Monte Carlo [[2]](https://academic.oup.com/biomet/article/96/4/983/220502)
* **SMC:** Sequential Monte Carlo [[3]](https://link.springer.com/article/10.1007/s11222-011-9271-y)
* **RSMC:** Replenishement Sequential Monte Carlo [[4]](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1541-0420.2010.01410.x)

and an implementation of the toy model,

* **ToyEx:** Toy example proposed by [[5]](https://www.pnas.org/content/104/6/1760?ijkey=d09a94d7744324fa718c59a5e96d840d39a67485&keytype2=tf_ipsecsha)
* **L2:** Compute the L2 distance between a simulated (weighted particles) and 
the true posterior density for the toy example proposed by 
[[5]](https://www.pnas.org/content/104/6/1760?ijkey=d09a94d7744324fa718c59a5e96d840d39a67485&keytype2=tf_ipsecsha)
* **sample:** Sample x particles from a weighted distribution 

## References

[1] Lenormand *et al.* (2013) [Adaptive approximate Bayesian computation for complex models.](https://link.springer.com/article/10.1007/s00180-013-0428-3) 
*Computational Statistics* 28, 2777-2796. [[arXiv](https://arxiv.org/abs/1111.1308)]

[2] Beaumont *et al.* (2009) [Adaptive  approximate  Bayesian  computation](https://academic.oup.com/biomet/article/96/4/983/220502). *Biometrika* 96, 983–990.

[3] Del  Moral *et al.* (2012) [An  adaptive  sequential  Monte  Carlo  method  for  approximateBayesian computation](https://link.springer.com/article/10.1007/s11222-011-9271-y). *Statistics and Compututing* 22, 1009–1020. 

[4] Drovandi & Pettitt (2011) [Estimation of parameters for macroparasite population evolution usingapproximate Bayesian computation](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1541-0420.2010.01410.x). *Biometrics* 67, 225–233.

[5] Sisson *et al.* (2007) [Sequential Monte Carlo without likelihoods](https://www.pnas.org/content/104/6/1760?ijkey=d09a94d7744324fa718c59a5e96d840d39a67485&keytype2=tf_ipsecsha). *PNAS* 104, 1760-1765.

## Citation

If you use this code, please cite:

Lenormand M, Jabot F & Deffuant G (2013) [Adaptive approximate Bayesian computation for complex models.](https://link.springer.com/article/10.1007/s00180-013-0428-3) 
*Computational Statistics* 28, 2777-2796. [[arXiv](https://arxiv.org/abs/1111.1308)]

If you need help, find a bug, want to give me advice or feedback, please contact me!

## Repository mirrors

This repository is mirrored on both GitLab and GitHub. You can access it via the following links:

- **GitLab**: [https://gitlab.com/maximelenormand/apmc](https://gitlab.com/maximelenormand/apmc)  
- **GitHub**: [https://github.com/maximelenormand/apmc](https://github.com/maximelenormand/apmc)  

The repository is archived in Software Heritage:

[![SWH](https://archive.softwareheritage.org/badge/origin/https://github.com/maximelenormand/APMC/)](https://archive.softwareheritage.org/browse/origin/?origin_url=https://github.com/maximelenormand/APMC)
