# Performance metrics for multiclass classification

| Metrics           | Description                                                                                       |
| ----------------- | ------------------------------------------------------------------------------------------------- |
| accuracy          | calculated as: (TP+TN) / (TP+FP+TN+FN) (doesn't show up when output.as.table = TRUE)              |
| balanced.accuracy | calculated as: (TP / (TP+FN)+TN / (TN+FP)) / 2 = (recall+specificity) / 2                         |
| DOR               | calculated as: TP\*TN / (FP\*FN) = L / lambda                                                     |
| error.rate        | calculated as: (FP+FN) / (TP+TN+FP+FN) = 1-accuracy (doesn't show up when output.as.table = TRUE) |
| F0.5              | calculated as: 1.25\*(recall\*precision/(0.25\*precision+recall))                                 |
| F1                | calculated as: 2\*(precision\*recall / (precision+recall))                                        |
| F2                | calculated as: 5\*(precision\*recall / (4\*precision+recall))                                     |
| FDR               | calculated as: 1-precision                                                                        |
| FNR               | calculated as: 1-recall                                                                           |
| FOR               | calculated as: 1-NPV                                                                              |
| FPR               | calculated as: 1-specificity                                                                      |
| geometric.mean    | calculated as: (recall\*specificity)^0.5                                                          |
| Jaccard           | calculated as: TP / (TP+FP+FN)                                                                    |
| L                 | calculated as: recall / (1-specificity)                                                           |
| lambda            | calculated as: (1-recall) / (specificity)                                                         |
| MCC               | calculated as: (TP\*TN-FP\*FN) / (((TP+FP)\*(TP+FN)\*(TN+FP)\*(TN+FN))^0.5)                       |
| MK                | calculated as: precision + NPV - 1                                                                |
| NPV               | calculated as: TN / (TN+FN)                                                                       |
| OP                | calculated as: accuracy - |recall-specificity| / (recall+specificity)                             |
| precision         | calculated as: TP / (TP+FP)                                                                       |
| recall            | calculated as: TP / (TP+FN)                                                                       |
| specificity       | calculated as: TN / (TN+FP)                                                                       |
| Youden            | calculated as: recall+specificity-1                                                               |


Further reading: https://rdrr.io/cran/mltest/man/ml_test.html    
Original code is here: https://github.com/cran/mltest/blob/master/R/ml_test.R

**Disclaimer: this is not mine, I just put it in my GitHub for my pesonal use since the package is no longer available on CRAN**
