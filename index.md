<link rel="alternate" type="application/atom+xml" title="{{ site.title }}" href="/feed.xml">
<h1> RT Dose Response - A Critique of "HYTEC" Methodology </h1><br>
<p align="left">
Recently, work on dose response modelling for radiotherapy, specifically “HYTEC” project and “PENTEC” project, has been published, work for which this reader is appreciative, and would thank the authors for their contribution. <br>
<br />
 As an example is work [1] searching, compiling, and analyzing relevant data in a group of small brain metastases ≤ 2.0 cm, with the authors estimating 1-year local control of 85% and 95% for 18 and 24 Gy, respectively, and estimating 50% tumor control dose (TCD50) 11.21 Gy single fraction equivalent dose (SFED) using alpha/beta=20, with 95% confidence interval of 10.43-11.90. <br>
 <br />
However, several issues undercut the author’s conclusions, issues which likely generalize to the greater HYTEC work. First, the authors describe use of a logistic model applied to SFED with outcome of local control (LC). <br> </p>
<br /> <center>
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/fig1.png?raw=true" width="300">  <br>
<br />  </center>                                              
A fundamental assumption inherent to specification of the author’s model is a y-intercept of 0; this implies 0 local control from other background therapies, including whole brain radiotherapy and systemic therapies, and ignores competing risks including death from extracranial disease. These are not valid assumptions. <br>
<br />
Maximal likelihood estimates depend on the distributional assumptions made for the dose-response model. [2] <br>
<br />
For binomial data, the likelihood function [3] takes the form: <br>
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/fig%202.png?raw=true" width="300">  <br>                                           
Of which taking the ln of both sides gives the log-likelihood function: <br>
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/fig%203.png?raw=true" width="450">  
<br> <br />
Minimization of the negative log-likelihood function is then performed, which for continuous data is minimization of nonlinear least squares, for response y<sub>i</sub> as a function of dose x<sub>i</sub> and with weights w<sub>i</sub>: <br>
<center>
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/fig%204.png?raw=true" width="300">  <br>
</center>
Where beta are the model parameters. The Hessian matrix of second-order partial derivatives can be calculated to determine the variance-covariance matrix solution numerically [2]. <br>
The author’s treatment of the actuarial local control data is not specified in the manuscript, and only in a separate "primer" article (https://doi.org/10.1016/j.ijrobp.2020.11.020) do they note general use of log likelihood function for binomial data, so one must assume that is their treatment here as well. The author’s provided tumor control probability equation was created as a function and modelled for small metastases outcome of 1-year LC using R package <i>drc</i> [2]. As an example, treating 1-year LC rates as a continuous variable produces results with TCD50 of 15.6. <br> <br /> As an aside, I notice that the author’s table EA1 would total to N=12,197 for ≤ 2.0 cm brain metastases; underneath this, table EA4 for ≤ 2.0 cm metastasis notes N=10,106 – an unexplained discrepancy. <br>
<br /> <center>
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/drm%20bin.png?raw=true">  <br>
type="binomial", AIC=1375, log likelihood=-686<br> </center>
<br />
<center>
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/cont%20drm.png?raw=true">  <br>
type="continuous", AIC=449 log likelihood=-221<br>
<br />
</center>
Profile likelihood estimates are provided, the methodology of which is unspecified, but appear much smaller than nonparametric bootstrapped [4] 1-year local control of created HYTEC "logistic" function with package <i>drc</i>, type=binomial. As example, bootstrapping this HYTEC "logistic" model to estimate model parameters of TCD50 and Gamma50 for comparison to author's reported data: <br>
<br />
<blockquote>
Number of bootstrap replications R = 1000 <br>
  original  bootBias bootSE  bootMed <br>
1 11.02912 -1.827515 4.6973 11.22436 <br>
2  0.88248 -0.073918 0.4194  0.87013 <br>
</blockquote>
<br />


<blockquote> 
boot.ci(results, index=1) <br>
BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS <br>
Based on 1000 bootstrap replicates <br>
<br />
CALL : <br>
boot.ci(boot.out = results, index = 1) <br>
<br />
Intervals : <br>
Level      Normal              Basic    <br>     
95%   ( 3.65, 22.06 )   ( 7.77, 22.05 )  <br>
<br />
Level     Percentile            BCa   <br>       
95%   ( 0.01, 14.28 )   ( 0.01, 14.39 )  <br>
Calculations and Intervals on Original Scale <br>
</blockquote>
<br />
Notice the magnitude of the empiric CI of TCD50 parameter by nonparametric bootstrapping, with basic bootstrap 95% confidence intervals from ~7.8-22, suggesting model parameter instability - something is badly wrong with trying to force fit the author's "logistic" model to this data!<br>
<br />
“Fisher exact test, median splits” p-values are provided, but it is unclear what the hypothesis being tested is. <br>
<br />
At this point, let's check the distribution of the outcome 1-year LC data, making use of <i>fitdistrplus</i>:
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/cullenfrey.png?raw=true">  <br> <br />
<b> So 1-year LC, a proportion bounded by 0 and 1, is consistent (not surprisingly) with Beta distribution. Did authors not evven check basic data type/distribution? </b> <br> <br />
This is of importance in terms of maximal likelihood estimates, because it appears the likelihood function for the wrong data distribution was used. As per Owen [5]<br> <br />
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/betall.png?raw=true"> <br> <br />
Goodness-of-fit parameters were compared with other models for correct data type; a penalized cubic regression spline generalized additive model (GAM), k=5, beta regression family, was created with package <i>mgcv</i>. <br> <br />Akaike information criterion [6] (AIC) was estimated at 1375.4 (author's model) vs -33535 for the GAM, evidence of poor fit of the author’s chosen model. Similarly, log likelihood was estimated at -686 vs 16773, respectively, further evidence of poor fit of author's model.  Author’s fitted model <b> demonstrated an estimated 36% higher bias than the maximal likelihood fitted GAM model estimates as below</b>. Unfortunately, the authors make no such estimation of model goodness-of-fit, performance, or alternate model comparison. No obvious dose response above ~18-20 Gy SFED is noted in the GAM fit - in contrast to author's conclusion. <br>
<br />
<blockquote>
library(Metrics)
bias(df$LC1Yr, fitted(drm.bin))/bias(df$LC1Yr), fitted(gam_k5))<br>
[1] 1.355909
</blockquote> <br><br />
<img src="https://github.com/KingJuliusss/RT-Dose-Response/blob/main/gamk5.png?raw=true">  <br> <br />
Next, the published median 1-year overall survival was estimated as 32%, with a range of 18-71% and multiple missing values. Such high competing risk of death with local control warrants consideration, suggesting significant individual study level variance in terms of 1-year local control, simply due to censoring alone. Variances, including of the individual study-level outcomes being modelled is essential data, the absence of which confounds meaningful interpretation of this medical physics dose response work.  <br>
 <br />
Sample sizes appear to have been used as weights rather than the inverse of the variance; there is no mention of assessment of publication bias in the included studies, as is standard for meta-analysis/meta-regression. <br>
<br />
Once again, the work of the authors of such work is appreciated; author's reported dose-response for small metastases is <b><u>spurious,</u></b> and this example likely generalizes to the larger HYTEC work.<b> Would not such research question be much better served with proper methodology, i.e. dose response meta-regression, to estimate a dose-response curve from multiple summarized dose-response data, accounting for correlation amongst observations and heterogeneity across studies, under the employ of expert statistical support? Jackson et. al. [7] provide example of this for prostate cancer. <br> <br /> Basic statistical considerations, such as type of data/data distribution, appear to have not been examined in author's work. Rather than assume the data fits a model, would it not be better to select a model that best fits the data? It is discomforting to see a guest editor also be author/co-author on same work. The necessity of having the best possible information to apply clinically argues for better methodology here. </b> <br>
<br />
<br />
1) Redmond KJ, et al. Tumor Control Probability of Radiosurgery and Fractionated Stereotactic Radiosurgery for Brain Metastases. Int J Radiat Oncol Biol Phys. 2020 Dec 31:50360-3016(20)34451-5. Doi: 10.1016/j.ijrobp.2020.10.034. Epub ahead of print. PMID: 33390244. <br>
2) Ritz C, Baty F, Streibig JC, Gerhard D. Dose-Response Analysis Using R. PLoS One. 2015 Dec 30;10(12):e0146021. doi: 10.1371/journal.pone.0146021. PMID: 26717316; PMCID: PMC4696819. <br>
3) http://courses.atlas.illinois.edu/spring2016/STAT/STAT200/RProgramming/Maximum_Likelihood.html <br>
4) Davison AC, Hinkley DV (1997). Bootstrap Methods and Their Applications. Cambridge University Press, Cambridge. ISBN 0-521-5739 2, http://statwww.epfl.ch/davison/BMA/. <br>
5) Owen, Claire Elayne Bangerter, "Parameter Estimation for Beta Distribution" (2008). Theses and Dissertations. 1614.
6)Sakamoto Y, Ishiguro M, Kitigawa G. (1986). Akaike Information Criterion Statistics. D. Reidel Publishing Company. <br>
7)Jackson WC, Silva J, Hartman HE, Dess RT, Kishan AU, Beeler WH, Gharzai LA, Jaworski EM, Mehra R, Hearn JWD, Morgan TM, Salami SS, Cooperberg MR, Mahal BA, Soni PD, Kaffenberger S, Nguyen PL, Desai N, Feng FY, Zumsteg ZS, Spratt DE. Stereotactic Body Radiation Therapy for Localized Prostate Cancer: A Systematic Review and Meta-Analysis of Over 6,000 Patients Treated On Prospective Studies. Int J Radiat Oncol Biol Phys. 2019 Jul 15;104(4):778-789. doi: 10.1016/j.ijrobp.2019.03.051. Epub 2019 Apr 6. PMID: 30959121; PMCID: PMC6770993.

<a class="btn btn-rss" href="/feed.xml" target="_blank">RSS</a>
 

