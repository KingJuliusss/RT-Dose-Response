<p align="center"> <h1> RT Dose Response </h1> </p> <br>
<p align ="left">
Recently, work on dose response modelling for radiotherapy, specifically “HYTEC” project and “PENTEC” project, has been published, work for which this reader is appreciative. <br>
As an example is work [1] searching, compiling, and analyzing relevant data in a group of small brain metastases ≤ 2.0 cm, with the authors estimating 1-year local control of 85% and 95% for 18 and 24 Gy, respectively, and estimating 50% tumor control dose (TCD50) 11.21 Gy single fraction equivalent dose (SFED) using a/b=20, with 95% confidence interval of 10.43-11.90. 
However, several issues undercut the author’s conclusions, issues which may generalize to the greater HYTEC work. First, the authors describe use of a logistic model applied to SFED with outcome of local control (LC). <br> </p>

<img src="/fig 1.png" width="400">  <br>
                                                
A fundamental assumption inherent to specification of the author’s model is a y-intercept of 0; this implies 0 local control from other background therapies, including whole brain radiotherapy and systemic therapies, and ignores competing risks including death from extracranial disease. These are not valid assumptions. <br>
 
Maximal likelihood estimates depend on the distributional assumptions made for the dose-response model. [2] <br>
 
For binomial data, the likelihood function [3] takes the form: <br>

<img src="/fig 2.png" width="400">  <br>
                                               
Of which taking the ln of both sides gives the log-likelihood function: <br>

<img src="/fig 3.png" width="400">  <br>
                                                
Minimization of the negative log-likelihood function is then performed, which for continuous data is minimization of nonlinear least squares, for response yi as a function of dose xi and with weights wi: <br>

<img src="/fig 4.png" width="400">  <br>

Where b are the model parameters. The Hessian matrix of second-order partial derivatives can be calculated to determine the variance-covariance matrix solution numerically [2]. <br>
 
The author’s treatment of the actuarial local control data is not specified. The author’s provided tumor control probability equation was created as a function and modelled for small metastases outcome of 1-year LC using R package drc [2]. Treating 1-year LC rates as a continuous variable produces results that differ than author’s results, with TCD50 of 15.6. In fact, I notice that the author’s table EA1 would total to N=12,197 for ≤ 2.0 cm brain metastases; underneath this, table EA4 for ≤ 2.0 cm metastasis notes N=10,106 – an unexplained discrepancy. <br>
 
Profile likelihood estimates are provided, the methodology of which is unspecified, but appear much smaller than nonparametric bootstrapped [4] 1-year local control, for example, for SFED=18: <br>


<blockquote> 
BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS < br>
Based on 1000 bootstrap replicates <br>
 
CALL : <br>
boot.ci(boot.out = results) <br>
 
Intervals : <br>
Level      Normal              Basic         <br>
95%   ( 0.7636,  0.9331 )   ( 0.7743,  0.9342 )  <br>
 
Level     Percentile            BCa          <br>
95%   ( 0.7641,  0.9240 )   ( 0.7614,  0.9230 )  <br>
Calculations and Intervals on Original Scale <br>
</blockquote>

“Fisher exact test, median splits” p-values are provided, but it is unclear what the hypothesis being tested is. <br>
<br />
Goodness-of-fit parameters were compared with other models, with the log-likelihood of the author’s stated function (assuming they treated data as binomial) was calculated as -685.7, whereas the log-likelihood of a generalized additive model (GAM) with thin plate regression splines was quite better at 20.3: <br>

<img src="/fig 5.png">  <br>
                                    
Akaike information criterion [5] (AIC) was similarly estimated at 1375.4 vs -28.1, further evidence of poor fit of the author’s chosen model.  Author’s fitted model demonstrated an estimated 80% higher bias than the GAM fitted model estimates. Unfortunately, the authors make no such estimation of model goodness-of-fit, performance, or alternate model comparison. No obvious response is noted in the GAM fit above approximately 18 Gy, as in the figure above, in contrast to the author’s conclusions. <br>
<br />
Next, the published median 1-year overall survival was estimated as 32%, with a range of 18-71% and multiple missing values. Such high competing risk of death with local control warrants consideration, suggesting significant individual study level variance in terms of 1-year local control, simply due to censoring alone. Variances, including of the individual study-level outcomes being modelled is essential data, the absence of which confounds meaningful interpretation of this medical physics dose response work.  <br>
 <br />
Once again, the work of the authors of such dose modelling work is appreciated; however, would not such work be much better served with dose response meta-regression under the employ of expert statistical support? Rather than assume the data fits a model, would it not be better to select a model that best fits the data? The necessity of having the best possible information to apply clinically argues for better methodology here. <br>
 
 
1) Redmond KJ, et al. Tumor Control Probability of Radiosurgery and Fractionated Stereotactic Radiosurgery for Brain Metastases. Int J Radiat Oncol Biol Phys. 2020 Dec 31:50360-3016(20)34451-5. Doi: 10.1016/j.ijrobp.2020.10.034. Epub ahead of print. PMID: 33390244.
2) Ritz C, Baty F, Streibig JC, Gerhard D. Dose-Response Analysis Using R. PLoS One. 2015 Dec 30;10(12):e0146021. doi: 10.1371/journal.pone.0146021. PMID: 26717316; PMCID: PMC4696819.
3) http://courses.atlas.illinois.edu/spring2016/STAT/STAT200/RProgramming/Maximum_Likelihood.html
4) Davison AC, Hinkley DV (1997). Bootstrap Methods and Their Applications. Cambridge University Press, Cambridge. ISBN 0-521-5739 2, http://statwww.epfl.ch/davison/BMA/.
5)Sakamoto Y, Ishiguro M, Kitigawa G. (1986). Akaike Information Criterion Statistics. D. Reidel Publishing Company.
 
 



