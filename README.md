# 8.0-Regression-With-Dummy-Variables

# What is a Dummy Variable
Most times regression analysis requires that we have independent and dependent variables that are continuous (e.g., examining the effects of attendance on a numerical class grade). However, regression analysis can also be run with a categorical independent variable if it is coded as a dummy or indicator variable (0 and 1). In which 0 indicates the absence of the variable and 1 indicates the presence of the variable. The use of this 0 and 1 notation is referred to as dummy coding.

![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/6332a154-d430-44eb-bcd6-719c81773f27)

A good example of this can be found in this week’s material. In this example, the analyst is testing the relationship between a categorical independent variable with 3 categories (“response_time_v2”: less than 500, between 500 and 1000, and more than 1000) and a continuous dependent variable (“num_attack”: number of cyberattacks an organization receives in a year). The research question is, does response time influence the number of cyber attacks an organization receives in a year? In this regression model, we can see that the analyst is using "less than 500" as the comparison group. 

![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/5d01d4d2-b388-4a61-8171-ad3aff91bc56)

We can also see from the regression model that:

The subcategories of response time are added to the regression model as predictors and are listed in alphabetical order
There is one less than the number of subcategories (k) in our prediction model (i.e., k -1)

# How to Dummy Code
We use k-1 predictors in our model because one of the groups needs to serve as the comparison group or baseline condition. By default, R will place your subcategories into alphabetical order (i.e., between 500 and 1000, less than 500, or more than 1000) and use the first group (between 500 and 1000) as your comparison group.

![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/933c3111-f4f2-4417-941c-53b39d46fe09)

Let's load the following sample data into R:
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/3b114de9-60bb-4468-baee-274a81900828)

In the data set, we can see that response_time_v2 is classified as a "Factor" and has 3 levels (i.e., a categorical variable with 3 subcategories) and that num_attack is classified as "num" which means it is a numeric or continuous variable.

When dummy coding, you would assign a 0 to your control group (as shown in the second row of the table below) and 1’s to the other groups (e.g., Dummy Variable 1 represents “Between 500 and 1000” and therefore has a 1 coded for that group and 0’s for all other groups).

![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/269019ae-52ae-4aa9-9518-c97cf2d6fb0a)

We can use the contr.treatment() function to override the default comparison group and dummy code our variables in R.
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/b05e08ae-e1d5-4bf9-a425-2d00a69949ef)

cyberData is the name of the data frame
response_time_v2 is the name of the categorical variable
3 is the number of subcategories
base=2 states the 2nd group will be used as the comparison group
In our Global Environment, we can see that the attributes of “response_time_v2” have been updated with the new contrasts.

Earlier Description of "response_time_v2"
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/6ffebb59-bdcc-41b3-a23c-c2cec0de9374)


Updated description of "response_time_v2"
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/f2a54d92-6356-4ade-844e-10bed695310a)

We can also manually create new variables and specify what values should be treated as 0’s and 1’s. This is a 2-step process. First, create the new variables. Second, specify the contrasts in R.
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/6f5fdd23-a21d-4273-83fd-412a0ac78ca8)

When coding, remember that the alphabetical ordering of the subcategories is:
1 = Between 500 and 1000
2 = Less than 500
3 = More than 1000

These represent the first, second, and third positions in the c() parameters.

For example, btw_500_and_1000_VS_LessThan_500 = c(1,0,0) would therefore set the subcategory “between 500 and 1000” to 1 and all other groups to 0.

The last statement concatenates the newly created dummy variables in the “response_time_v2” variable using the cbind() function.

In our Global Environment, we can see that the attributes of “response_time_v2” have once again been updated with the new contrasts.

Earlier description of "response_time_v2"
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/b749f75c-beea-48d7-8dca-9ed4d2d5981a)

Updated description of "response_time_v2"
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/53ac50fb-4a5c-4d28-97ea-306c10be8aa1)

The dummy variables now have more descriptive names as opposed to 1, and 2.

Just like with simple and multiple regression, the lm() function is what we use to fit our linear model in R.

 cyberModel <- lm(num_attack~response_time_v2, data=cyberData)
 summary(cyberModel)
![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/f8e4e4e0-4f04-454b-8443-0a006b5ec42c)


Note that the slopes reported for each dummy variable indicate the strength of the relationship between the mean differences and your dependent variable. You can use the following command to get the actual means in each of the four groups:

round(tapply(cyberData$num_attack, cyberData$response_time_v2, mean, na.rm = TRUE), 3)

cyberData$num_attack: is the dependent variable
cyberData$response_time_v2: is the independent variable
mean: is the statistical function we’re requesting
3: rounds to 3 decimal places

![image](https://github.com/Xnrrrrrr/8.0-Regression-With-Dummy-Variables/assets/133546385/b2680881-97c6-4a3f-b41b-a1d7c53216f9)

# How to Interpret the Results
In your results, you want to be sure to mention the significance of the overall effect, the R-squared value, the means of each group, and the slope and significance level of each mean difference. Below is a sample write-up of the output shown above.

The results show that overall, the response time has a statistically significant effect on the number of cyberattacks an organization receives in a year (p = 2.764e-16). Based on our R-squared value, response time helps to explain 30.49% of the variability in the number of cyberattacks. When compared to organizations that respond to a cyberattack in less than 500 hours (x̄  = 153.077 ), the number of cyberattacks was significantly higher for the organizations that respond to a cyberattack in between 500 and 1000 hours (x̄1 =201.286, β1 = 48.209, p = .1.24e-05) and the organizations that respond to a cyberattack in more than 1000 hours (x̄2 = 272.308, β2 = 119.231, p = 2e-16).

 










