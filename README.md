# Measurements-in-Data-Science-Coursework
This is a coursework from my module in measurements in data science.

Q1 
1.1 Trust in international political institutions could be an alternative, combining trust in the EU parliament and in the UN to reflect shared roles in supranational governance. 

1.2.  Figure 1: Histograms and boxplots of trust item. 
   
  
 ![boxplots](https://github.com/user-attachments/assets/edaff8fb-c5e0-4466-8447-a210737f46b8)


  
  

Table 1: Results of trust variables 
 

Looking at Figure and Table 1, trust variables appear generally right skewed, indicating a neutral to lower trust in institutions is more common among respondents. 
Trust in the police has the highest mean (6.45) with a right-skewed distribution, while trust in politicians and parties are the lowest (3.55 and 3.53), concentrated at the scale's lower end. Additionally, trust in the UN and the EU Parliament falls in the middle, with means of 5.04 and 4.54 respectively, with the most common response being neutral (5).  
Looking at standard deviation the range of 2.42 to 2.8 indicates moderate but consistent response variability across the scale and items.
Overall, this suggests that people trust the police most, view political entities sceptically, and hold less clivant opinions on institutional bodies, highlighting measurement challenges as skewness often stems from latent biases.

1.3. 
Figure 2: Distribution of the trust index 
 
The index represents the average trust level on a 0 to 10 scale, 0 being “no trust” and 10 as “complete trust”. Scores are the average of trust in all the institution for each respondent.  The distribution is nearly normal, with fewer scores in the 8 and above range, and a mean at 4.7 showing a slight skew to lower trust levels. 
In our index we assume that all items are equally as important in the overall respondent trust. Additionally, complete case analysis assumes respondents to all questions to not differ from partial responders, which if not missing-at-random, increases the risk of selection bias. 
1.4 
Figure 3: Predicted trust index by country 
 
Table 2: Regression results for trust index by country


As seen on Table 2, coefficients represent the average trust relative to the reference country, Austria, which has a baseline trust score of 4.61. 

Sweden shows the highest relative trust with a coefficient of +0.55, while Bulgaria has the lowest at -1.50. Figure 3 highlights that Nordic countries like Norway and Finland score above 6, confidence reflecting strong institutional confidence, while Eastern European countries, that historically had weaker governance, fall below 4 indicating lower trust. The p-values of France, Italy, and Portugal suggest similar trust levels to Austria. 

However, the low R-squared value where only 13.6% of the variance in trust levels is explain by the model, indicating that additional factors influence trust perceptions beyond country-level differences.


 
1.5. 
Table 3: Regression results for socio-demographic predictors of trust

As shown in Table 3, all predictors for trust index are statistically significant, except where household income is missing.  

The baseline of 3.653, represents the trust index for an 18-year-old male without a university degree, living in a non-urban area, in a low-income household, and not engaged in paid work or retirement.

Being a woman increases trust by 0.058 units, while each additional interval of age raises trust by 0.005 units, suggesting older individuals and women exhibit slightly higher trust. Education has a stronger effect, with a university degree increasing trust by 0.693 units, and urban living adds 0.167 units, highlighting greater trust among city residents.

Looking at household income, higher groups (Q2 to Q5) show a progressively greater trust than the lowest group (Q1), with an increase from 0.141 to 0.681 units on average.

Employment status also matters, with those in paid work or retirement showing higher trust than those in "other activities," with increases of 0.350 and 0.301 units, respectively. However, the baseline category could be misleading by probably including both unemployed individuals and those in non-traditional work, which could affect interpretation.

However, the low R-squared value (5%) suggests that while socio-demographic factors affect trust, they explain only a small portion of the variance, indicating other factors contribute more to the variations in trust.

1.6. 
Table 4: Regression results for trust level for voting

Table 4 presents the model with voting as the dependent variable. The baseline value of 0.704 indicates that when the trust index is 0, the predicted probability of voting is 70.4%. The estimate of 0.024 shows that for each unit increase in the trust index, the probability of voting increases by 2.44%. 

Although the results are statistically significant, the effects are small. Higher trust levels are associated with a marginally higher likelihood of voting. However, the model explains only 1.6% of the variance in voting, indicating that other factors likely contribute more to voting behaviour.

1.7. When the index is used as a dependent variable, measurement error in the variables could bias the constructed index, potentially misleading the results. However, as independent variable, errors mostly affect predictors rather than outcome, reducing bias in outcome association. 

1.8.  
Figure 4: Comparing PC1 and equal weight trust index 
 

Figure 4 shows a strong positive relationship between PC1 and the trust index, with points clustering almost in a straight line. The correlation of 0.99 suggests that PC1 captures nearly all the variance in the trust index, making it a good summary of the data. 
This makes PC1 a more efficient summary of the data, capturing the key patterns influencing trust. Still the equal weight index could be simpler to interpret and useful to communicate results. 



 
Q2 
2.1.
Figure 5: Correlation matrix of democratic ideal
 
 

In Figure 5, the strongest correlation is between "people's views prevail" and "the will of the people is unstoppable" (0.557), possibly reflecting direct democracy or populist ideals. Another strong correlation between "courts treat people fairly" and "fair elections" (0.535), seems to represent broader belief in democratic institutions integrity.
Conversely, the weak correlation between "people's views prevail" and "fair elections" (0.174) suggests a disconnect between public empowerment and perceptions of procedural fairness in elections.
Overall, all correlations are positive and statistically significant, although by their variation in strength, highlighting the complexity of interpreting democratic ideals. 

2.2. PCA is an unsupervised statistical method that transforms the observed variables into a multiple of uncorrelated linear combinations called principal components. Each PC is the weighted sum of the original variables, with usually the first three components capturing most of the variance. 
PCA is a data reduction method, summarising variance without relying on a theoretical framework, making it a discriminative measure.
Secondly, EFA is also an unsupervised statistical method that identifies latent factors explaining the correlations between observed variables. It assumes these variables are influenced by unobserved constructs and specific errors. EFA falls under latent variable models, where observed measures reflect underlying relationships between latent factors and indicators, making it a generative measure.

Both methods reduce the dimensionality of data by summarising variability into fewer elements. They are also both statistical approaches that avoid reliance on equal weighting or subjective expert input, often leading to less biased results. However, PCA ensures components are uncorrelated, while EFA allows factors to be correlated. Additionally, PCA explains the total variance in the data, while EFA includes error terms due to estimating fewer factors. 

2.3.
Table 4.1: EFA loadings and uniqueness values. 
 

Table 4.2:  EFA explained variance by factor. 
 

Table 4.3: EFA hypothesis testing results 
 
From Table 4.1, Factor 1 strongly loads on "courts treat people fairly" (0.68) and "fair elections" (0.75), explaining 56.25% and 46.24% of their variance respectively, highlighting the importance of fair judicial processes and electoral systems. 
Factor 2, with loadings of 0.73 for both "people’s views prevail" and "the will of the people is unstoppable," highlights the role of public influence, implying that Factor 2 explains 53.29% of the variance in each of these variables. 
Uniqueness values show "fair elections" is well-explained by the factors (0.42), while "final say by referendum" (0.64) suggests the need for additional latent factors.
In table 4.2, just under half of the variability in the observed variables is captured by the model (49.5%), with Factor 1 accounting for 25.2% and Factor 2 for 24.2%. This shows a reasonable amount of explanatory power, but more than half of the variance remains unexplained. Table 4.3 confirms the results are statistically significant.
From the EFA, Factor 1 seems to reflect the strength of democratic institutions, possibly relating to indirect democratic processes. On the other hand, Factor 2 emphasises the role of the people in democratic processes, potentially aligning with themes of direct democracy or populist rhetoric. 
Q3
3.1. According to our findings, some questions seem to better capture the variance than others, consequently, equal weighting is inappropriate for interpretations. 

3.2.   We cannot use loadings as weights because they represent the correlation between indicators and the latent factor, not direct weights. Their values depend on the data scale and rotation applied and using them without adjustment would double-count shared variance. 

3.3. 
Table 5: Regression results on relative perceived levels of democracy. 
 
The regression presents country differences in perceived democracy relative to Austria, with baseline scores of 7.51 for Factor 1 and 3.35 for Factor 2

Most coefficients are significant, except for Germany and Iceland (Factor 1), and Estonia, Greece, Iceland, Italy, Lithuania, and Portugal (Factor 2), where perceptions are similar to Austria. 

Bulgaria, Croatia, and Poland have negative coefficients on both factors, especially for Factor 1, indicating lower democratic quality. In contrast, Norway and Switzerland score positively on both factors, with stronger results for Factor 2.
 
Table 6: Ranking positions and differences
 

When looking at rankings, Table 6 highlights significant differences, especially for Hungary (11 ranks), Germany (9), and Slovakia (8), showing that how democratic features weights affects perceptions. 
These findings highlight the challenges of measuring democracy, as countries may differ significantly depending on which features are prioritised, emphasising the multidimensional nature of the target concept. 



 
