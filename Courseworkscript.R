# R Script Coursework
# 2025-01-11

# libraries 
library(readr)
library(dplyr)
library(ggplot2)
library(corrplot)
library(reshape2)
library(skimr)
library(formattable)
library(sjPlot)
library(ggthemes)

# Load the data 
load("/Users/Downloads/ess.rda")

# Question 1
# 2. Construct a set of histograms for the trust variables.
# Creating a subset for "trust" variables 
t <- ess %>% 
  select("trust_legal_system","trust_police", "trust_politicians", "trust_parties", "trust_parliament", "trust_eu_parliament", "trust_united_nations")

# Renaming variables 
colnames(t) <- c(
  "trust in the legal system", 
  "trust in the police ", 
  "trust in politicians", 
  "trust in political parties", 
  "trust in parliament", 
  "trust in the EU parliament ", 
  "trust in the UN"
)

# My colour palette 
colours <- c("#001f3f", "#0074D9", "#4B0082", "#7FDBFF", "#7B68EE", "#1f77b4", "#83BFE6")

for (var in names(t)) {
  # histogram
  p1 <- ggplot(t, aes_string(x = paste0("`", var, "`"))) +
    geom_histogram(binwidth = 0.5, fill = colours[which(names(t) == var)], color = "white") +
    labs(title = paste("Histogram for", var), x = "Value", y = "Frequency") +
    theme_minimal(base_size = 10) +
    theme(plot.title = element_text(hjust = 0.5, size = 12))
  
  # boxplot
  p2 <- ggplot(t, aes_string(x = "1", y = paste0("`", var, "`"))) +
    geom_boxplot(outlier.colour = "red", outlier.size = 3) +
    labs(title = paste("Boxplot for", var), x = NULL, y = "Value") +
    theme_minimal(base_size = 10) +
    theme(plot.title = element_text(hjust = 0.5, size = 12))
  
  # Arrange the plots (histogram and boxplot side by side)
  grid.arrange(p1, p2, ncol = 2)
  
# Trust items means and standard deviations
  # Table summary of t
  summary_stats <- data.frame(
    Mean = round(colMeans(t, na.rm = TRUE) , 3),
    "Standard Deviation" = round(apply(t,2, sd, na.rm = TRUE)  , 3))
  formattable(summary_stats)

  # 3. Construct an equal weight index out of the trust_ variables.
  # creating a complete case 
  complete_ess <- ess[complete.cases(ess[,grepl("trust", names(ess))]),]
  
  complete_t <- complete_ess %>% 
    select("trust_legal_system","trust_police", "trust_politicians", "trust_parties", "trust_parliament", "trust_eu_parliament", "trust_united_nations")
  
  # Create a colum with an index with complete observersions
  complete_t$trust_index <- rowMeans(complete_t)
  complete_ess$trust_index <- complete_t$trust_index
  
  # Normalise the index 
  complete_ess$trust_index <- (complete_t$trust_index - min(complete_t$trust_index)) / (max(complete_t$trust_index) - min(complete_t$trust_index)) * 10
  Plotting our trust index
  # Plot histogram
  ggplot(complete_ess, aes(x = trust_index)) +
    geom_histogram(binwidth = 0.5, fill = "#1f77b4", color = "white") +
    # Adding a Gaussian curve to show index distribution vs. normal distribution 
    # (using chatgpt to print normal distribution on top of the plot)
    stat_function(
      fun = function(x) {
        dnorm(x, mean = mean(complete_ess$trust_index, na.rm = TRUE), 
              sd = sd(complete_ess$trust_index, na.rm = TRUE)) * 
          nrow(complete_ess) * 0.5
      },
      color = "orange",
      linewidth = 1
    ) + labs(
      title = "Distribution of Trust Index",
      x = "Trust Index",
      y = "Frequency"
    ) +
    theme_minimal()
  
  Trust index mean
  # Finding the mean for the trust index 
  m <- mean(complete_t$trust_index, na.rm = TRUE)
  m
  ## [1] 4.729239
  4. Run a linear regression model regressing the equal weight index on dummy variables for each country.
  country_trust_reg <- lm(trust_index ~ country, data = complete_ess, weights = wgt)
  
  # Table regression 
  tab_model(country_trust_reg, title = "Regression Results", 
            dv.labels = "Trust Index", show.ci = FALSE, show.p = TRUE)
  # Plot regression 
  plot_model(country_trust_reg, type="pred", sort.est = T) + 
    labs(x="Countries",y="Predicted values of trust index",title="Predictd trust index by country") + 
    # Adding lines when trust equals 4 and 6 to see lowest and highest trust regions
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + geom_hline(yintercept = 4, linetype = "dashed", color = "blue") + 
    geom_hline(yintercept = 6, linetype = "dashed", color = "blue")    
  
  5. Run a linear regression model with the equal weight index as dependent variable and socio-demographic predictors
  # Run the regression with predictors
  predictors_reg <- lm(trust_index ~ female + age + degree + urban + household_income + activity, data = complete_ess, weights = wgt)
  
  # Display the results
  tab_model(predictors_reg, title = "Regression Results", 
            dv.labels = "Trust Index", show.ci = FALSE, show.p = TRUE, digits = 3)
  6.Run a linear regression model regressing the voting as a dependent and trust index as independent.
  # Run the regression of voting patterns on trust index
  voting_regression <- lm(voted ~ trust_index, data = complete_ess, weights = wgt)
  
  # Table the regression
  tab_model(voting_regression, title = "Regression Results", 
            dv.labels = "Voting", show.ci = FALSE, show.p = TRUE, digits = 3)
  8. Principal component analysis
  # PCA on the seven trust variables
  pcafit <- prcomp(complete_t[, 1:7], center = TRUE, scale. = FALSE)
  
  # First principal component scores
  complete_ess$PC1 <- pcafit$x[, 1]
  
  # Scatter plot 
  ggplot(complete_ess, aes(x = trust_index, y = PC1)) + 
    geom_point(color = "blue") + 
    # Adding correlation between PC1 and equal weight index 
    # (using chatgpt to print the correlation value on top of the plot )
    annotate("text", x = max(complete_ess$trust_index), y = max(complete_ess$PC1), 
             label = paste("Correlation = ", round(cor(pcafit$x[, 1], complete_ess$trust_index), 4)),
             color = "black", hjust = 5.5, vjust = 1, size = 3) + 
    labs(
      x = "Equal weight trust index",
      y = "PC1"
    ) + 
    theme_minimal()
  
  
  Question 2
  1. Calculate and plot the pairwise correlations.
  ## Subset the variables
  v <- ess[, c("courts_treatsame_imp", "fair_elections_imp", "critical_media_imp", 
               "finalsay_referendum_imp", "peopleviews_prevail_imp", "willpeople_unstoppable_imp")]
  
  # Rename the columns 
  colnames(v) <- c("Courts treat same", "Fair elections", "Critical media",
                   "Final say referendum", "People views prevail", 
                   "Will people unstoppable")
  
  # Calculate the correlation matrix
  cor_matrix <- cor(v, use = "complete.obs")
  
  #Line 1 & 2 needs to be run together 
  #L1 
  corrplot(cor_matrix, method = "color", order = 'AOE', type = 'upper', tl.pos = 'd', tl.cex = 0.6, tl.col = "black") 
  #L2 
  corrplot(cor_matrix, add = TRUE, type = 'lower', method = 'number', order = 'AOE', 
           diag = FALSE, tl.pos = 'n', cl.pos = 'n', number.cex = 1.5)
  
  Looking if the correlation are statistically significant.
  # Showing statitical significance 
  sig <- all(cor.mtest(v)$p < 0.001)
  
  # Print the result with if else (using ChatGPT to create efficient if-else statement)
  if (sig) {
    print("All correlation results are highly significant (p < 0.001).")
  } else {
    print("Not all correlation results are highly significant (p < 0.001).")
  }
  ## [1] "All correlation results are highly significant (p < 0.001)."
  3. Exploratory factor analysis with two latent factors on the _imp items.
  Given code
  fafit <- factanal(ess[, grepl("*imp$", names(ess))], 
                    
                    factors = 2, scores = "regression", rotation = "varimax")
  Present the results in a table
  # 1) Create data frames 
  ## Factor loadings and uniquenesses
  ## Using ChatGPT to re-transcribe factor analysis results 
  table_factor_analysis <- data.frame(
    Variables = c("Courts treat same", "Fair elections", "Critical media",
                  "Final say referendum", "People views prevail", 
                  "Will people unstoppable"),  
    Factor1 = c(0.676, 0.753, 0.605, 0.262, 0.111, 0.199),
    Factor2 = c(0.223, 0.118, 0.190, 0.543, 0.728, 0.733),
    Uniqueness = c(0.494, 0.420, 0.597, 0.636, 0.457, 0.423)
  )
  
  # Variance 
  variance <- data.frame(
    Metric = c("SS Loadings", "Proportion Variance", "Cumulative Variance"),
    Factor1 = c(1.510, 0.252, 0.252),
    Factor2 = c(1.462, 0.244, 0.495)
  )
  
  # Tests 
  tests <- data.frame(
    Metric = c("Chi-square", "Degrees of freedom", "P-value"),
    Value = c(50.31, 4, 3.1e-10)
  )
  
  
  # 2) Format using formattable
  formattable(table_factor_analysis, 
              list(
                Variables = formatter("span"),
                # Using chat gpt to highlight highest values 
                Factor1 = color_tile("white", "#83BFE6"),
                Factor2 = color_tile("white", "#7FDBFF"),
                Uniqueness = color_tile("white", "#7B68EE")
              ))
  
  
  Question 3
  3. Run two linear regressions for sq_factor1 and sq_factor2.
  fa_weights <- solve(fafit$correlation) %*% fafit$loadings
  
  ess$sq_factor1 <- as.matrix(ess[,grepl("*sq$", names(ess))]) %*% fa_weights[,1] 
  ess$sq_factor2 <- as.matrix(ess[,grepl("*sq$", names(ess))]) %*% fa_weights[,2]
  
  # Two regressions for staus quo  
  reg_factor1 <- lm(sq_factor1 ~ country, data = ess, weights = wgt)
  reg_factor2 <- lm(sq_factor2 ~ country, data = ess, weights = wgt)
  # Display regression results in a single table
  tab_model(
    reg_factor1, reg_factor2,
    show.ci = FALSE,
    dv.labels = c("Factor 1", "Factor 2"),
    title = "Regression Results"
  )
  Create a ranking to better compare status quo factors
  # Combine coefficients into a single data frame
  coef_data <- data.frame(
    Country = sub("^country", "", names(coef(reg_factor1))[-1]),
    Factor1_Coefficient = coef(reg_factor1)[-1],
    Factor2_Coefficient = coef(reg_factor2)[-1]
  )
  
  # Calculate rank differences between Factor 1 and Factor 2
  coef_data$Rank_Factor1 <- rank(coef_data$Factor1_Coefficient)
  coef_data$Rank_Factor2 <- rank(coef_data$Factor2_Coefficient)
  coef_data$Rank_Difference <- abs(coef_data$Rank_Factor1 - coef_data$Rank_Factor2)
  
  # Sort by rank difference
  coef_data <- coef_data[order(-coef_data$Rank_Difference), ]
  
  # Display the table with rank differences highlighted
  ## Using ChatGPT to improuve formatting and add a barplot visualisation 
  library(formattable)
  formattable(
    coef_data[, c("Country", "Rank_Difference")],
    list(Rank_Difference = color_bar("lightblue"))
  )
  
  
  
  
  
  