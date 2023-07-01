# Credit-Risk-Assessment-and-Predictive-Modeling
Interpretation of the result of the confusion matrix:

Accuracy: 
The overall accuracy of the model is 0.9935 or 99.35%.
This indicates that the model correctly predicts the credit risk categories (Low, Medium, High) for approximately 99.35% of the instances in the dataset.

95% Confidence Interval (CI):
The accuracy has a 95% confidence interval between 0.9646 and 0.9998.

No Information Rate (NIR):
The no information rate represents the accuracy achieved by a naive model that always predicts the most prevalent class.
Here, the NIR is 0.8194 or 81.94%. The model's accuracy is significantly better than the NIR, indicating that it is providing valuable predictions.

Kappa:
The Kappa statistic is a measure of agreement between the model's predictions and the actual classes.
A Kappa of 0.9789 indicates very high agreement between the predicted and actual classes.

Sensitivity, Specificity, Positive Predictive Value, Negative Predictive Value:

Sensitivity represents the proportion of actual positive instances correctly predicted as positive.
Here, the model has a sensitivity of 1.0000 for the "Low" and "Medium" classes, meaning it correctly identifies all instances of these classes.
For the "High" class, the sensitivity is 0.83333, indicating that the model correctly identifies 83.33% of the "High" risk instances.

Specificity is the proportion of actual negative instances correctly predicted as negative.
This model has a specificity of 1.0000 for the "Low" class, indicating that it correctly identifies all instances of "Low" risk.
For the "Medium" class, the specificity is 0.9925, indicating that it correctly identifies 99.25% of the "Medium" risk instances.
The "High" class has a specificity of 1.0000, meaning it correctly identifies all "High" risk instances.

The positive predictive value (precision) measures the accuracy of the model's positive predictions.
The model has a precision of 1.0000 for the "Low" and "High" classes, indicating that all instances predicted as "Low" or "High" are correct.
For the "Medium" class, the precision is 0.9565, meaning 95.65% of the instances predicted as "Medium" are correct.

The negative predictive value measures the accuracy of the model's negative predictions.
The model has a negative predictive value of 1.0000 for the "Low" class, indicating that all instances predicted as "Not Low" are correct.
For the "Medium" class, the negative predictive value is 1.0000, indicating that all instances predicted as "Not Medium" are correct.
For the "High" class, the negative predictive value is 0.99333, meaning 99.33% of the instances predicted as "Not High" are correct.

Prevalence, Detection Rate, Detection Prevalence:
Prevalence is the proportion of instances belonging to each class in the dataset.
The prevalence of "Low," "Medium," and "High" risk classes are 0.8194, 0.1419, and 0.03871, respectively.
Detection rate measures the proportion of actual positive instances correctly predicted by the model.
The detection rates for the "Low," "Medium," and "High" classes are 0.8194, 0.1419, and 0.03226, respectively.
Detection prevalence measures the proportion of predicted positive instances in the dataset.
The detection prevalences for the "Low," "Medium," and "High" classes are 0.8194, 0.1484, and 0.03226, respectively.

Overall, the model exhibits high accuracy and good performance in predicting credit risk categories.
It shows high sensitivity, specificity, and precision for most classes, indicating its ability to identify and classify instances correctly.
However, the performance for the "High" risk class is slightly lower compared to the other classes, as reflected in the lower sensitivity and balanced accuracy.
This could suggest that the model might struggle to correctly identify instances with high credit risk.

We'll use some other predictive models to see the differences between the performances and choose the best one. 
