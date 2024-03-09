#Step 1: Import the data file named "cyber-attack-dc.csv" into R by using read.csv() function.

cyberData <- read.csv("cyber-attack-dc.csv", header = TRUE)

#Step 2: Click on the arrow to the left of cyberData in the Global Environment to expand its content. If you see the categorical variable response_time_v2 is not listed as Factor, then execute the following command. Otherwise, skip to Step 3.

cyberData$response_time_v2 <- as.factor(cyberData$response_time_v2)

#Step 3: response_time_v2 in the dataframe called cyberData is a categorical variable. 
         #R treat the levels in response_time_v2 variable in alphabetical order (level 1 = Between 500 and 1000, level 2 = Less than 500, level 3 = More than 1000)
        #We use contrasts() function on this categorical variable to set contrasts. Assume that we want to compare the group "Between 500 and 1000" and the group "More than 1000" to the group "Less than 500". In this case, our baseline group is "Less than 500" that is level 2.
        #We use contr.treatment() function to set a contrast based on comparing all groups to a baseline condition.

contrasts(cyberData$response_time_v2) <- contr.treatment(3, base =2) #where we want to set the contrast for the varibale response_time_v2 in the cyberData dataframe.

# contr.treatment() function is used here to set the contrast based on comparing both "Between 500 and 1000" and "More than 1000 to the baseline group "Less than 500".
# With the command above, we have told R that there are three groups, and that we use the group 2 (or level 2) as the baseline group.

#Step 4: Let's see what the command in Step 3 has done by looking at the response_time_v2 variable by executing:

cyberData$response_time_v2

#Step 5: Now we have created the dummy variables, we can run the regression by using lm() function:

cyberModel <- lm(num_attack~response_time_v2, data=cyberData)
summary(cyberModel)

#Step 6: As you may have noticed, it is a bit difficult to interpret the results because the way contrasts named, such as response_time_v21, does not give us any idea what contrast it is.
  #Therefore, it is a good idea to name the contrast we want to see.

btw_500_and_1000_VS_LessThan_500 <- c(1,0,0) #contrast 1
moreThan_1000_VS_LessThan_500<- c(0,0,1)#contrast 2

contrasts(cyberData$response_time_v2) <- cbind(btw_500_and_1000_VS_LessThan_500, moreThan_1000_VS_LessThan_500)

        #we use cbind() function to concatenate the newly created dummy variables in the “response_time_v2” variable. 

#Step 7: Let's re-run the regression analysis by executing the following command:
cyberModel <- lm(num_attack~response_time_v2, data=cyberData)
summary(cyberModel)

    # We can now interpret the results easily. 

#Step 8: We use tapply() function to calculate the group means for each of group (or category in the response_time_v2 variable)

groupMeans<-tapply(cyberData$num_attack, cyberData$response_time_v2, mean, na.rm=TRUE)

        #We use round() function to round mean scores (we round the means scores to 3 decimal places in this case)

roundedGroupMeans<-round(groupMeans, 3)
print(roundedGroupMeans)

# or you can execute the following syntax to get the same means scores.

round(tapply(cyberData$num_attack, cyberData$response_time_v2, mean, na.rm = TRUE), 3)



